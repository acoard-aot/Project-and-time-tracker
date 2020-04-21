import { getRepository, Repository } from 'typeorm';
import { Project } from '../../models/entities';
import { Client } from '../../models/entities';
import { IProject } from '../../models/interfaces/i-project';
import { Timesheet } from './../../models/entities/timesheet.entity';
import { TimesheetEntry } from './../../models/entities/timesheetEntry.entity';
import { IClient } from '../../models/interfaces/i-client';
import { type } from 'os';
import { ReplaceSource } from 'webpack-sources';

import { FinanceExport } from '../../models/entities';
import { IFinanceExport } from '../../models/interfaces/i-finance-export';
import { IFinanceExportDetail } from '../../models/interfaces/i-finance-export-detail';
import { IFinanceJSON } from '../../models/interfaces/i-finance-json';

const financeRepo = (): Repository<FinanceExport> => {
  return getRepository(FinanceExport);
};
const timesheetRepo = (): Repository<Timesheet> => {
  return getRepository(Timesheet);
};
const projectRepo = (): Repository<Project> => {
  return getRepository(Project);
};

const clientRepo = (): Repository<Client> => {
  return getRepository(Client);
};

export const createProject = async (obj: IProject | IProject[]) => {
  if (Array.isArray(obj)) {
    const arr: any = [];
    for (let index = 0; index < obj.length; index++) {
      arr.push(await createProject(obj[index]));
    }
    return arr;
  }

  const project: Project = projectRepo().create(obj);
  project.dateCreated = new Date();
  project.dateModified = new Date();
  await projectRepo().save(project);
  return project;
};

export const updateProject = async (
  id: string,
  fields: any,
  clientFilds: any = null
) => {
  const repo = projectRepo();
  const project: Project = await repo.findOne(id);

  if (!project) {
    throw Error('project not found');
  }
  const updatedProject = await repo.merge(project, fields);
  updatedProject.dateModified = new Date();

  if (fields.backupUserId === undefined) updatedProject.backupUserId = null;
  if (fields.leadUserId === undefined) updatedProject.leadUserId = null;
  await repo.save(updatedProject);
  if (clientFilds) {
    const repoClient = clientRepo();
    const client: Client = await repoClient.findOne(clientFilds.id);

    if (!client) {
      throw Error('client not found');
    }
    const updatedClient = await repoClient.merge(client, clientFilds);
    updatedClient.dateModified = new Date();

    await repoClient.save(updatedClient);
  }
  return updatedProject;
};

export const deleteProject = async (id: string) => {
  const repo = projectRepo();
  const project = await repo.findOne(id);

  if (!project) {
    throw Error('project not found');
  }
  return await repo.delete(project);
};

export const retrieveProjectById = async (id: string | string[]) => {
  const repo = projectRepo();
  if (Array.isArray(id)) {
    const arr: any = [];
    for (let index = 0; index < id.length; index++) {
      arr.push(await retrieveProjectById(id[index]));
    }
    return arr;
  }
  const res = await repo
    .createQueryBuilder('p')
    .innerJoinAndSelect('p.client', 'c')
    .leftJoinAndSelect('c.ministry', 'm')
    .leftJoinAndSelect('p.mou', 'o')
    .where('p.id = :id', { id: id })
    .getOne();
  if (!res) {
    throw Error(`project not found for the id specified: ${id}`);
  }
  return res;
};

export const retrieveProjects = async () => {
  const repo = projectRepo();
  return await repo
    .createQueryBuilder('p')
    .innerJoin('p.client', 'c')
    .leftJoin('c.ministry', 'm')
    .leftJoinAndSelect('p.mou', 'o')
    .innerJoin('p.projectSector', 'ps')
    .orderBy('p.dateModified', 'DESC')
    .select([
      'p.id',
      'p.projectName',
      'ps',
      'p.dateModified',
      'p.completionDate',
      'c.orgDivision',
      'm.ministryName',
      'p.leadUserId',
      'p.backupUserId',
      'o.name',
      'o.id',
      'p.isReprocurement',
      'c.isNonMinistry',
      'p.dateOfReprocurement',
      'p.previousContractBackground',
      'p.projectFailImpact',
      'p.projectSuccess',
      'p.otherProjectSectorName',
      'c.nonMinistryName',
      'p.mouAmount',
      'p.teamWideProject'
    ])
    .where('p.is_archived IS NULL OR p.is_archived = :is_archived', {
      is_archived: false
    })
    .getMany();
};

function uuidv4() {
  return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
    var r = (Math.random() * 16) | 0,
      v = c == 'x' ? r : (r & 0x3) | 0x8;
    return v.toString(16);
  });
}
export const retrieveFinanceData = async (obj, userId) => {
  const financeExport = obj as IFinanceExport[];
  const documentNo: string = uuidv4();

  for (let index = 0; index < financeExport.length; index++) {
    let model = financeExport[index];
    if (!model) {
      return [];
    }
    const exportData = {} as IFinanceJSON;
    exportData.projectId = financeExport[index].projectId;
    const repo = projectRepo();
    const res = await repo
      .createQueryBuilder('p')
      .innerJoin('p.client', 'c')
      .select([
        'p.id',
        'p.projectName',
        'c.responsibilityCenter',
        'c.clientNo',
        'c.stob',
        'c.projectCode',
        'c.serviceCenter'
      ])
      .where('p.id = :projectId', {
        projectId: exportData.projectId
      })
      .getOne();

    exportData.projectName = res.projectName;
    if (res.client) {
      exportData.responsibilityCenter = res.client.responsibilityCenter;
      exportData.clientNo = res.client.clientNo;
      exportData.stob = res.client.stob;
      exportData.projectCode = res.client.projectCode;
      exportData.serviceCenter = res.client.serviceCenter;
    }
    exportData.documentNo = documentNo;
    exportData.lineDesc = documentNo;
    exportData.createdUserId = userId;

    const timeSheet = await timesheetRepo()
      .createQueryBuilder('t')
      .leftJoinAndSelect('t.timesheetEntries', 'te')
      .innerJoinAndSelect('t.user', 'u')
      .innerJoinAndSelect('u.contact', 'c')
      .where(
        't."projectId" = :projectId and (t.is_locked = :is_locked or t.is_locked IS NULL)',
        { projectId: exportData.projectId, is_locked: false }
      )
      .getMany();
    if (timeSheet.length == 0) {
      continue;
    }

    let details = [] as IFinanceExportDetail[];
    for (
      let timeSheetIndex = 0;
      timeSheetIndex < timeSheet.length;
      timeSheetIndex++
    ) {
      for (
        let timeSheetEntryIndex = 0;
        timeSheetEntryIndex < timeSheet[timeSheetIndex].timesheetEntries.length;
        timeSheetEntryIndex++
      ) {
        const timesheetEntry: TimesheetEntry[] =
          timeSheet[timeSheetIndex].timesheetEntries;
        if (
          timesheetEntry[timeSheetEntryIndex].hoursBillable &&
          timesheetEntry[timeSheetEntryIndex].hoursBillable > 0
        ) {
          let financeDetailHour = {} as IFinanceExportDetail;
          financeDetailHour.entryDate =
            timesheetEntry[timeSheetEntryIndex].entryDate;
          financeDetailHour.description =
            timesheetEntry[timeSheetEntryIndex].commentsBillable;
          financeDetailHour.hours =
            timesheetEntry[timeSheetEntryIndex].hoursBillable;
          financeDetailHour.type = 'Time';
          financeDetailHour.user = timeSheet[timeSheetIndex].userId;
          financeDetailHour.resource =
            timeSheet[timeSheetIndex].user.contact.fullName;
          financeDetailHour.rate = timeSheet[timeSheetIndex].user.contact
            .hourlyRate
            ? timeSheet[timeSheetIndex].user.contact.hourlyRate
            : 0;
          financeDetailHour.amount =
            financeDetailHour.rate * financeDetailHour.hours;
          details.push(financeDetailHour);
        }

        if (
          timesheetEntry[timeSheetEntryIndex].expenseAmount &&
          timesheetEntry[timeSheetEntryIndex].expenseAmount > 0
        ) {
          let financeDetailExpense = {} as IFinanceExportDetail;
          financeDetailExpense.entryDate =
            timesheetEntry[timeSheetEntryIndex].entryDate;
          financeDetailExpense.description =
            timesheetEntry[timeSheetEntryIndex].expenseComment;
          financeDetailExpense.amount =
            timesheetEntry[timeSheetEntryIndex].expenseAmount;
          financeDetailExpense.type = 'Expense';
          financeDetailExpense.user = timeSheet[timeSheetIndex].userId;
          financeDetailExpense.resource =
            timeSheet[timeSheetIndex].user.contact.fullName;
          details.push(financeDetailExpense);
        }
      }
      exportData.details = details;

      let fees = exportData.details
        .filter(item => item.type === 'Time')
        .reduce(function(prev, cur) {
          return prev + Number(cur.amount);
        }, 0);

      let expenses = exportData.details
        .filter(item => item.type === 'Expense')
        .reduce(function(prev, cur) {
          return prev + Number(cur.amount);
        }, 0);

      exportData.fees = fees;
      exportData.expenses = expenses;
      exportData.totalAmount = fees + expenses;
      exportData.dateCreated = new Date();
      model.createdUserId = userId;
      model.documentNo = documentNo;
      model.exportData = JSON.stringify(exportData);

      await createFinanceExport(model);

      timeSheet[timeSheetIndex].is_locked = true;
      await timesheetRepo().save(timeSheet[timeSheetIndex]);
    }
  }

  // await createFinanceExport(financeExport);
  const repo = financeRepo();
  const result = await repo
    .createQueryBuilder('f')
    .where('f."documentNo" = :documentId ', { documentId: documentNo })
    .getMany();

  return result;
};
export const createFinanceExport = async (obj: IFinanceExport) => {
  obj.dateCreated = new Date();
  await financeRepo().save(obj);
  return obj;
};

export const retrieveArchivedProjects = async () => {
  const repo = projectRepo();
  return await repo
    .createQueryBuilder('p')
    .innerJoin('p.client', 'c')
    .innerJoin('c.ministry', 'm')
    .leftJoinAndSelect('p.mou', 'o')
    .innerJoin('p.projectSector', 'ps')
    .orderBy('p.dateModified', 'DESC')
    .select([
      'p.id',
      'p.projectName',
      'ps',
      'p.dateModified',
      'p.completionDate',
      'c.orgDivision',
      'm.ministryName',
      'p.leadUserId',
      'p.backupUserId',
      'p.mouAmount',
      'p.isReprocurement',
      'p.isMinistry',
      'p.dateOfReprocurement',
      'p.previousContractBackground',
      'p.projectFailImpact',
      'p.projectSuccess',
      'p.otherProjectSectorName',
      'o.name',
      'p.teamWideProject'
    ])
    .where('p.is_archived = :is_archived', { is_archived: true })
    .getMany();
};

export const retrieveTimesheetProjects = async obj => {
  const repo = timesheetRepo();

  const res = await repo
    .createQueryBuilder('t')
    .select('DISTINCT t.project', 'id')
    .where(
      '(t.startDate >= :start and t.startDate <= :end)  and (t.is_locked = :is_locked or t.is_locked IS NULL)',
      {
        start: obj.startDate,
        end: obj.endDate,
        is_locked: false
      }
    )
    .getRawMany();

  return res;
};
export const retrieveExportedPdfs = async obj => {
  const repo = financeRepo();

  const res = await repo
    .createQueryBuilder('t')
    .select('DISTINCT t.documentNo', 'documentNo')
    // .select('t.dateCreated', 'dateCreated')
    // .select('t.documentPath', 'documentPath')
    .getRawMany();

  return res;
};
export const retrieveAllProjects = async () => {
  const repo = projectRepo();
  return await repo
    .createQueryBuilder('p')
    .innerJoin('p.client', 'c')
    .leftJoin('c.ministry', 'm')
    .leftJoinAndSelect('p.mou', 'o')
    .innerJoin('p.projectSector', 'ps')
    .orderBy('p.dateModified', 'DESC')
    .select([
      'p.id',
      'p.projectName',
      'ps',
      'p.dateModified',
      'p.completionDate',
      'c.orgDivision',
      'm.ministryName',
      'p.leadUserId',
      'p.backupUserId',
      'o.name',
      'o.id',
      'p.isReprocurement',
      'c.isNonMinistry',
      'p.dateOfReprocurement',
      'p.previousContractBackground',
      'p.projectFailImpact',
      'p.projectSuccess',
      'p.otherProjectSectorName',
      'c.nonMinistryName',
      'p.mouAmount',
      'p.teamWideProject'
    ])
    .where('(p.is_archived IS NULL OR p.is_archived = :is_archived)', {
      is_archived: false
    })
    .getMany();
};
export const retrieveProjectsByUserId = async (userId: string) => {
  const repo = projectRepo();
  return await repo
    .createQueryBuilder('p')
    .innerJoin('p.client', 'c')
    .leftJoin('c.ministry', 'm')
    .leftJoinAndSelect('p.mou', 'o')
    .innerJoin('p.projectSector', 'ps')
    .orderBy('p.dateModified', 'DESC')
    .select([
      'p.id',
      'p.projectName',
      'ps',
      'p.dateModified',
      'p.completionDate',
      'c.orgDivision',
      'm.ministryName',
      'p.leadUserId',
      'p.backupUserId',
      'o.name',
      'o.id',
      'p.isReprocurement',
      'c.isNonMinistry',
      'p.dateOfReprocurement',
      'p.previousContractBackground',
      'p.projectFailImpact',
      'p.projectSuccess',
      'p.otherProjectSectorName',
      'c.nonMinistryName',
      'p.teamWideProject'
    ])
    .where(
      '(p.is_archived IS NULL OR p.is_archived = :is_archived) AND (p."leadUserId" = :userId OR p."backupUserId" = :userId OR p.teamWideProject=true)',
      {
        is_archived: false,
        userId
      }
    )
    .getMany();
};

export const retrieveArchivedProjectsByUserId = async (userId: string) => {
  const repo = projectRepo();
  return await repo
    .createQueryBuilder('p')
    .innerJoin('p.client', 'c')
    .innerJoin('c.ministry', 'm')
    .innerJoin('p.projectSector', 'ps')
    .select([
      'p.id',
      'p.projectName',
      'ps',
      'p.dateModified',
      'p.completionDate',
      'c.orgDivision',
      'm.ministryName',
      'p.leadUserId',
      'p.backupUserId',
      'p.mouAmount',
      'p.isReprocurement',
      'p.isMinistry',
      'p.dateOfReprocurement',
      'p.previousContractBackground',
      'p.projectFailImpact',
      'p.projectSuccess',
      'p.otherProjectSectorName',
      'p.teamWideProject'
    ])

    //   From merge conflict, this line replaced below
    //     .where('p."leadUserId" = :userId OR p."backupUserId" = :userId', {
    //       userId: userId
    //     })
    .where(
      'p."is_archived" = :is_archived, {is_archived : true}) AND p."leadUserId" = :userId OR p."backupUserId" = :userId OR p.teamWideProject=true',
      { userId: userId }
    )
    .getMany();
};

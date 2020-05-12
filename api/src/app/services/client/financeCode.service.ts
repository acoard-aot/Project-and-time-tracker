import { getRepository, Repository } from 'typeorm';
import { IFinanceCodes } from '../../models/interfaces/i-finance-codes';
import { FinanceCodes } from '../../models/entities/financeCodes.entity';
import { Project } from '../../models/entities';

const financeCodeRepo = (): Repository<FinanceCodes> => {
  return getRepository(FinanceCodes);
};

export const createFinanceCodes = async (obj: IFinanceCodes) => {
  const financecode: FinanceCodes = financeCodeRepo().create(obj);
  await financeCodeRepo().save(financecode);
  return financecode;
};

export const retrieveAllFinanceCodes = async () => {
  const repo = financeCodeRepo();
  return await repo
    .createQueryBuilder('f')
    .getMany();
};

export const updatFinanceCodes = async (id: string, fields: any) => {
  const repo = financeCodeRepo();
  const fincodes: FinanceCodes = await repo.findOne(id);

  if (!fincodes) {
    throw Error('Finance Codes not found');
  }
  const updatedIntake = await repo.merge(fincodes, fields);
  // updatedIntake.dateModified = new Date();

  await repo.save(updatedIntake);
  return updatedIntake;
};



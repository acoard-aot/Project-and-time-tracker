<template>
  <v-card>
    <confirm ref="confirm"></confirm>
    <snackbar ref="snackbar"></snackbar>
    <v-toolbar v-if="title" card dense color="transparent">
      <v-toolbar-title>
        <h4>{{title}}</h4>
      </v-toolbar-title>
    </v-toolbar>
    <v-divider></v-divider>
    <v-card-text class="pa-0">
      <template>
        <v-data-table
          :headers="headers"
          :items="projects"
          hide-actions
          class="elevation-0 tm-v-datatable"
          disable-initial-sort
        >
          <template slot="items" slot-scope="props">
            <td class="text-xs-left">{{ props.item.mouAmount }} </td>
            <td v-bind:class="{ 'archived': props.item.is_archived}">{{ props.item.projectName }}</td>
            <td class="text-xs-left">{{ props.item.projectName }}</td>
            <td class="text-xs-left">{{ [props.item.client.ministry.ministryName, props.item.orgDivision].join(" ") }}</td>
            <td class="text-xs-left">{{ props.item.projectLeadUserId }}</td>
            <td class="text-xs-left">{{ props.item.projectBackupUserId }}</td>
            <td class="text-xs-left">{{props.item.completionDate}}</td>
            <td class="text-xs-left">{{ props.item.dateModified }}</td>
            <td class="text-xs-right">
              <v-btn flat icon color="grey" @click="archivePrompt(props.item, false)">
                <v-icon>unarchive</v-icon>
              </v-btn>
              <v-btn flat icon color="grey" @click="deleteProject(props.item.id)">
                <v-icon>delete</v-icon>
              </v-btn>
            </td>
          </template>
        </v-data-table>
      </template>
      <v-divider></v-divider>
    </v-card-text>
  </v-card>
</template>

<script>

import Confirm from '../common/Confirm.vue';
import Snackbar from '../common/Snackbar.vue';

export default {
  props: {
    title: String,
  },
  components: {
    Snackbar,
    Confirm,
  },
  data() {
    return {
      headers: [
        { text: 'MOU', value: 'mouAmount', align: 'left', sortable: true },
        { text: 'Project Name', value: 'projectName', align: 'left', sortable: true },
        { text: 'Phase', value: 'rfxPhaseName', align: 'left', sortable: true },
        { text: 'Client', value: 'client.ministry.ministryName', sortable: true },
        { text: 'Project Lead', value: 'projectLeadId', sortable: false },
        { text: 'Project Backup', value: 'projectBackup', sortable: false },
        { text: 'Project Deadline', value: 'completionDate', sortable: true },
        { text: 'Last Updated', value: 'dateModified', sortable: true },
        { text: 'Actions', value: 'is_archived', align: 'center', width: '145px', sortable: false,
        },
      ],
      archivedprojects: [],
      selectedLeadUser: '',
      selectedProjectBackup: '',
    };
  },
  computed: {
  projects() {
      return this.$store.state.archivedProjects;
    },
    userList() {
      return this.$store.state.users;
    },
  },
  methods: {
    fetchArchivedData() {
      this.$store.dispatch('fetchArchivedProjects');
    },
    editProject(id) {
      this.$router.push({ path: `project/${id}` });
    },
    viewProjectTimesheets() {
      this.$router.push({ path: 'timesheets' });
    },
    getProjectLead(projectLeadUserId) {
      this.selectedLeadUser = projectLeadUserId;
    },
    getProjectBackup(projectBackupId) {
      this.selectedProjectBackup = projectBackupId;
    },

    async deleteProject() {
      if (await this.$refs.confirm.open('danger', '')) {
        // yes
        this.$store.dispatch('fetchArchivedProjects');
        this.$refs.snackbar.displaySnackbar('success', 'Deleted.');
      }
    },
    async archivePrompt(item, archiveVal){
      if (
        await this.$refs.confirm.open(
          "info",
          `Are you sure to un-archive project: ${item.projectName}?`)
      )
      {
        item.is_archived = archiveVal;
        await this.$store.dispatch("archiveProject", item.id, archiveVal);
        this.$store.dispatch('fetchProjects');
      }
    },
  },
  created() {
    this.fetchArchivedData();
    },
};

</script>
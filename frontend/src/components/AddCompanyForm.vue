<template>
  <form v-on:submit.prevent>
    <div class="row">
      <input v-model="state.companySubmission.name" placeholder="Company Name">
    </div>

    <div class="row">
      <input v-model="state.companySubmission.website" placeholder="Company Website">
    </div>

    <div class="row">
      <autocomplete-search
        :placeholder="'Company Technology Tools'"
        :clear="state.clearForm"
        :searchList="state.searchTools"
        @updateSelectedList="state.companySubmission.tools = $event">
      </autocomplete-search>
    </div>

    <div class="row">
      <button type="submit" @click="submitCompany">Submit</button>
    </div>
  </form>
</template>

<script lang="ts">
import { defineComponent, onMounted, reactive } from "vue";

import { CompanySubmission, Tool } from '../interfaces';
import ToolDataService from '../services/tool-data.service';
import CompanySubmissionDataService from '../services/company-submission-data.service';

import AutocompleteSearch from './AutocompleteSearch.vue';

export default defineComponent({
  components: {
    'autocomplete-search': AutocompleteSearch,
  },
  setup() {
    let state = reactive<{
      companySubmission: CompanySubmission,
      searchTools: Tool[],
      clearForm: boolean,
    }>({
      companySubmission: {} as CompanySubmission,
      searchTools: [],
      clearForm: false,
    })

    onMounted(() => {
      ToolDataService.getAll().then((data) => {
        state.searchTools = data.tools;
      });
    });

    function submitCompany() {
      CompanySubmissionDataService.create(state.companySubmission).then((data) => {
        state.clearForm         = true;
        state.companySubmission = {} as CompanySubmission;
      });
    }

    return {
      state,
      submitCompany,
    }
  }
})
</script>

<style scoped>
.row:after {
  content: "";
  display: table;
  clear: both;
}

input {
  box-sizing: border-box; /* prevent padding from affecting width */
  width: 100%;
  border: 1px solid var(--border);
  border-radius: 0.3em;
  padding: 1em;
  margin-bottom: 2em;
}

button {
  float: right;
  padding: 1em;
  text-transform: uppercase;
}
</style>

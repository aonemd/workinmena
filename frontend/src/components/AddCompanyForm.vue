<template>
  <form v-on:submit.prevent>
    <div class="row">
      <input v-model="state.companySubmission.name" placeholder="Name">
    </div>

    <div class="row">
      <input
         v-model="state.companySubmission.website"
         placeholder="Website"
         @blur="analyzeCompanyWebsite">
    </div>

    <div class="row">
      <autocomplete-search
        :placeholder="'Stack Tools'"
        :clear="state.clearForm"
        :searchList="state.searchTools"
        :suggestedList="state.analyzedTools"
        @updateSelectedList="state.companySubmission.tools = $event">
      </autocomplete-search>
    </div>

    <div class="row">
      <button type="submit" @click="submitCompany">Submit</button>
    </div>
  </form>

  {{ state.apiMessage }}
</template>

<script lang="ts">
import { defineComponent, onMounted, reactive } from "vue";

import { CompanySubmission, Tool } from '../types';
import ToolDataService from '../services/tool-data.service';
import CompanySubmissionDataService from '../services/company-submission-data.service';
import CompanyAnalyzerDataService from '../services/company-analyzer-data.service';

import AutocompleteSearch from './AutocompleteSearch.vue';

export default defineComponent({
  components: {
    'autocomplete-search': AutocompleteSearch,
  },
  setup() {
    let state = reactive<{
      companySubmission: CompanySubmission,
      searchTools: Tool[],
      analyzedTools: Tool[],
      clearForm: boolean,
      apiMessage: string,
    }>({
      companySubmission: {} as CompanySubmission,
      searchTools: [],
      analyzedTools: [],
      clearForm: false,
      apiMessage: '',
    })

    onMounted(() => {
      ToolDataService.getAll().then((data) => {
        state.searchTools = data.tools;
      });
    });

    function analyzeCompanyWebsite() {
      CompanyAnalyzerDataService.create(state.companySubmission.website).then((data) => {
        state.analyzedTools = data.tools;
      });
    }

    function submitCompany() {
      CompanySubmissionDataService.create(state.companySubmission).then((data) => {
        state.clearForm         = true;
        state.companySubmission = {} as CompanySubmission;

        state.apiMessage = data.message;
      });
    }

    return {
      state,
      analyzeCompanyWebsite,
      submitCompany,
    }
  }
})
</script>

<style scoped>
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

<template>
  <div class="add-stack-form">
    <a
      href="#"
      class="company-add-tools-btn"
      @click="state.expandForm = !state.expandForm">
      Add technologies &oplus;
    </a>

    <div v-if="state.expandForm">
      <div class="row">
        <autocomplete-search
          :placeholder="'Search Tools'"
          :autofocus="true"
          :clear="!state.expandForm"
          :searchList="state.searchTools"
          @updateSearchQuery="updateAnalyticsWithSearchQuery($event)"
          @updateSelectedList="state.stackTools = $event">
        </autocomplete-search>
      </div>

      <div class="row">
        <button @click="handleOnSave">Save</button>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent, onMounted, reactive } from "vue";

import { Tool, StackEntrySubmission, } from '../../types';
import ToolDataService from '../../services/tool-data.service';
import CompanyStackDataService from '../../services/company-stack-data.service';
import AmplitudeWrapper from '../../services/amplitude-analytics-wrapper.service';

import AutocompleteSearch from "../AutocompleteSearch.vue";

export default defineComponent({
  components: {
    'autocomplete-search': AutocompleteSearch,
  },
  props: {
    companyId: Number,
  },
  setup(props, { emit }) {
    let state = reactive<{
      expandForm: boolean,
      searchTools: Tool[],
      stackTools: Tool[],
    }>({
      expandForm: false,
      searchTools: [],
      stackTools: [],
    });

    onMounted(() => {
      ToolDataService.getAll().then((data) => {
        state.searchTools = data.tools;
      });
    });

    function updateAnalyticsWithSearchQuery(query: string) {
      AmplitudeWrapper.logEvent('add_stack_tool_search_query', { query: query });
    }

    function handleOnSave() {
      let stackEntries: StackEntrySubmission[] = state.stackTools.map((tool) => {
        return {
          tool_id: tool.id,
          community: true,
        }
      });

      CompanyStackDataService.create(props.companyId!, stackEntries).then((data) => {
        emit('updateStackTools', data.stack_entries);
        state.expandForm = false;
      });
    }

    return {
      state,
      updateAnalyticsWithSearchQuery,
      handleOnSave,
    }
  }
})
</script>

<style scoped>
.add-stack-form {
  text-align: center;
  margin-bottom: 20px;
  font-size: 18px;

  & a {
    color: var(--main);
  }

  & button {
    float: right;
    padding: 1em;
    text-transform: uppercase;
  }
}
</style>

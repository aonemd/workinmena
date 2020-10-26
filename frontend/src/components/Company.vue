<template>
  <div id="company-box">
    <div class="company-info">
      <span class="company-title">{{state.company.name}}</span>

      <a :href="'//' + state.company.website" target="_blank" class="company-website">
        {{state.company.website}}
      </a>
    </div>

    <div class="company-add-tools">
      <a
        href="#"
        class="company-add-tools-btn"
        @click="state.expandAddToolsForm = !state.expandAddToolsForm">
        Add technologies &oplus;
      </a>

      <div v-if="state.expandAddToolsForm">
        <div class="row">
          <autocomplete-search
            :placeholder="'Search Tools'"
            :clear="false"
            :searchList="state.searchTools"
            @updateSelectedList="state.communityAddedTools = $event">
          </autocomplete-search>
        </div>

        <div class="row">
          <button>Save</button>
        </div>
      </div>
    </div>

    <ul class="tools">
      <li v-for="(tool, index) in state.company.tools" :key="index">
        <tool :tool="tool"></tool>
      </li>
    </ul>
  </div>
</template>

<script lang="ts">
import { defineComponent, onMounted, reactive } from "vue";

import { Company, Tool } from '../types';
import CompanyDataService from "../services/company-data.service";
import ToolDataService from '../services/tool-data.service';

import ToolVue from './Tool.vue';
import AutocompleteSearch from "./AutocompleteSearch";

export default defineComponent({
  props: {
    id: Number,
  },
  components: {
    'tool': ToolVue,
    'autocomplete-search': AutocompleteSearch,
  },
  setup(props) {
    let state = reactive<{
      company: Company,
      expandAddToolsForm: boolean,
      searchTools: Tool[],
      communityAddedTools: Tool[],
    }>({
      company: {} as Company,
      expandAddToolsForm: false,
      searchTools: [],
      communityAddedTools: [],
    });

    onMounted(() => {
      CompanyDataService.getOne(props.id!).then((data) => {
        state.company = data.company;
      });

      ToolDataService.getAll().then((data) => {
        state.searchTools = data.tools;
      });
    });

    return {
      state,
    }
  }
});
</script>
<style scoped>
#company-box {
  width: 100%;
  position: relative;

  background: var(--white);
  border-radius: 0.3em;
  margin-bottom: 1em;
  z-index: 1;
  display: table; /* so the elements inside act like table cells so that they can be vertically aligned in the middle */

  & .company-info {
    line-height: 1.25em;
    padding: 0 25px;
    vertical-align: middle;
    margin-bottom: 10px;

    & .company-title {
      font-weight: 700;
      font-size: 1.5em;
      color: var(--main);
    }

    & .company-website {
      float: right;
      padding-top: 0.4em;
      color: var(--secondary);
    }
  }

  & ul.tools {
    list-style: none;
    padding: 0;

    & li {
      margin-bottom: 1em;
    }
  }

  & .company-add-tools {
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
}
</style>

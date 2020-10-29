<template>
  <div id="company-box">
    <div class="company-info">
      <span class="company-title">{{state.company.name}}</span>

      <a :href="'//' + state.company.website" target="_blank" class="company-website">
        {{state.company.website}}
      </a>
    </div>

    <add-stack-form
      :companyId="state.id"
      @updateStackTools="addCommunityTools($event)" />

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

import ToolVue from './Tool.vue';
import AddStackForm from "./Company/AddStackForm.vue";

export default defineComponent({
  props: {
    id: Number,
  },
  components: {
    'tool': ToolVue,
    'add-stack-form': AddStackForm,
  },
  setup(props) {
    let state = reactive<{
      id: number,
      company: Company,
    }>({
      id: props.id!,
      company: {} as Company,
    });

    onMounted(() => {
      CompanyDataService.getOne(props.id!).then((data) => {
        state.company = data.company;
      });
    });

    function addCommunityTools(communityTools: Tool[]) {
      state.company.tools.unshift(...communityTools);

      let map: Map<number, boolean> = new Map();
      let stack: Tool[] = [];
      for (const tool of state.company.tools) {
        if (!map.has(tool.id)) {
          map.set(tool.id, true);
          stack.push(tool);
        }
      }
      state.company.tools = stack;

      console.log(state.company.tools);
    }

    return {
      state,
      addCommunityTools,
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
}
</style>

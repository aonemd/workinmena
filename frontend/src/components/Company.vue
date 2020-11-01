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
      @updateStackTools="addToStack($event)" />

    <ul class="company__stack">
      <li v-for="(stackEntry, index) in state.company.stack" :key="index">
        <stack :stackEntry="stackEntry" :companyId="state.id" />
      </li>
    </ul>
  </div>
</template>

<script lang="ts">
import { defineComponent, onMounted, reactive } from "vue";

import { Company, StackEntry } from '../types';
import CompanyDataService from "../services/company-data.service";
import AmplitudeWrapper from '../services/amplitude-analytics-wrapper.service';

import StackVue from './Company/Stack.vue'
import AddStackForm from "./Company/AddStackForm.vue";

export default defineComponent({
  props: {
    id: Number,
  },
  components: {
    'stack': StackVue,
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

        AmplitudeWrapper.logEvent(
          'company_visit',
          { id: state.company.id, name: state.company.name }
        );
      });
    });

    function addToStack(stackEntries: StackEntry[]) {
      state.company.stack.unshift(...stackEntries);

      let map: Map<number, boolean> = new Map();
      let stack: StackEntry[] = [];
      for (const stack_entry of state.company.stack) {
        if (!map.has(stack_entry.tool.id)) {
          map.set(stack_entry.tool.id, true);
          stack.push(stack_entry);
        }
      }
      state.company.stack = stack;
    }

    return {
      state,
      addToStack,
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

  & ul.company__stack {
    list-style: none;
    padding: 0;

    & li {
      margin-bottom: 1em;
    }
  }
}
</style>

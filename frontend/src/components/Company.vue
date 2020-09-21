<template>
  <div id="company-box">
    <div class="company-info">
      <span class="company-title">{{state.company.name}}</span>

      <a :href="'//' + state.company.website" target="_blank" class="company-website">
        {{state.company.website}}
      </a>

      <ul>
        <li v-for="(tool, index) in state.company.tools" :key="index">
          <tool :tool="tool"></tool>
        </li>
      </ul>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent, onMounted, reactive } from "vue";

import CompanyDataService from "../services/CompanyDataService";
import { Company } from '../interfaces';
import Tool from './Tool.vue';

export default defineComponent({
  props: {
    id: Number,
  },
  components: {
    'tool': Tool,
  },
  setup(props) {
    let state = reactive<{company: Company}>({
      company: {} as Company,
    });

    onMounted(() => {
      CompanyDataService.getOne(props.id!).then((data) => {
        state.company = data.company;
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
  border: 1px solid var(--border);
  border-radius: 0.3em;
  padding: 1em;
  margin-bottom: 1em;
  z-index: 1;
  display: table; /* so the elements inside act like table cells so that they can be vertically aligned in the middle */
  width: 96%;

  & .company-info {
    line-height: 1.25em;
    padding: 0 25px;
    vertical-align: middle;

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

    & ul {
      list-style: none;
      padding: 0;
    }
  }
}
</style>

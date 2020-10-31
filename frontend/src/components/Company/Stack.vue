<template>
  <div id="tool__box">
    <div class="tool__info">
      <div class="tool__title">
        <a :href="'//' + state.tool.website" target="_blank">
          {{state.tool.name}}
        </a>
      </div>

      <span class="tool__category">
        {{state.tool.category}}
      </span>
    </div>

    <div class="tool__endorsement">
      <span class="tool__endorsement-button">
        <a href="#" @click="endorse()">
          &uarr;
        </a>
      </span>

      <span class="tool__endorsement-number">
        {{state.endorsements}}
      </span>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent, PropType, reactive, } from "vue";

import { StackEntry, Tool } from '../../types';
import CompanyDataService from '../../services/company-stack-data.service';

export default defineComponent({
  props: {
    companyId: {
      type: Number,
    },
    stackEntry: {
      type: Object as PropType<StackEntry>,
      default: {} as StackEntry,
    },
  },
  setup(props) {
    let state = reactive<{ id: number, endorsements: number, tool: Tool, }>({
      id: props.stackEntry.id,
      endorsements: props.stackEntry.endorsements,
      tool: props.stackEntry.tool,
    });

    function endorse() {
      let stackEndorsements: { [key: string]: boolean; } = JSON.parse(localStorage.getItem('stackEndorsements') || "{}");
      let stackEntryEndorsementKey: string               = `${state.id}/endorsed`;

      if (!stackEndorsements.hasOwnProperty(stackEntryEndorsementKey)) {
        CompanyDataService.endorse(props.companyId!, state.id).then(() => {
          state.endorsements++;

          stackEndorsements[stackEntryEndorsementKey] = true;
          localStorage.setItem('stackEndorsements', JSON.stringify(stackEndorsements));
        });
      }
    }

    function excerpt(str: string, n: number = 170): string {
      return (str.length > n) ? str.substr(0, n-1) + '&hellip;' : str;
    }

    return {
      state,
      endorse,
    }
  }
});
</script>
<style scoped>
#tool__box {
  display: table;
  height: 70px;
  width: 100%;

  background: var(--white);
  border: 1px solid var(--border);
  border-radius: 0.3em;

  & .tool__info {
    display: table-cell;
    vertical-align: middle;
    width: 100%;
    padding: 1em;

    & .tool__title {
      float: left;
      & a {
        color: var(--main);
      }
    }

    & .tool__category {
      color: var(--secondary);
      font-size: 8px;
      float: right;
    }
  }

  & .tool__endorsement {
    float: right;
    display: grid;
    height: 100%;
    width: 40px;
    text-align: center;
    border: 1px solid var(--border);

    & span.tool__endorsement-button {
      font-size: 26px;
      cursor: pointer;

      & a {
        color: var(--main);
        text-decoration: none;
      }
    }

    & span.tool__endorsement-number {
      font-size: 8px;
    }
  }
}
</style>

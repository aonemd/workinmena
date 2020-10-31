<template>
  <div id="tool-box">
    <div class="tool__info">
      <div class="tool__title">
        <a :href="'//' + tool.website" target="_blank">
          {{tool.name}}
        </a>
      </div>

      <span class="tool-category">
        {{tool.category}}
      </span>
    </div>

    <div class="tool__endorsement">
      <span class="tool__endorsement-arrow">
        &uarr;
      </span>

      <span class="tool__endorsement-number">
        123
      </span>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent, PropType } from "vue";

import { Tool } from '../types';

export default defineComponent({
  props: {
    tool: {
      type: Object as PropType<Tool>,
    },
  },
  setup(props) {
    function excerpt(str: string, n: number = 170): string {
      return (str.length > n) ? str.substr(0, n-1) + '&hellip;' : str;
    }

    return {
      excerpt,
    }
  }
});
</script>
<style scoped>
#tool-box {
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

    & .tool-category {
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

    & span.tool__endorsement-arrow {
      font-size: 26px;
    }

    & span.tool__endorsement-number {
      font-size: 8px;
    }
  }
}
</style>

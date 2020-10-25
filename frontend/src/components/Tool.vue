<template>
  <div id="tool-box">
    <a :href="'//' + tool.website" target="_blank" class="tool-title">
      {{tool.name}}
    </a>
    &nbsp;
    <span class="tool-category">
      {{tool.category}}
    </span>
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
  height: 30px;

  background: var(--white);
  border: 1px solid var(--border);
  border-radius: 0.3em;
  padding: 1em;

  & .tool-title {
    color: var(--main);
  }

  & .tool-category {
    color: var(--secondary);
    font-size: 8px;
    float: right;
  }
}
</style>

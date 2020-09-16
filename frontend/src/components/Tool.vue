<template>
  <div id="tool-box">
    <div class="tool-info">
      <span class="tool-title">
        {{tool.name}}
      </span>

      <div class="tool-description" v-html="excerpt(tool.description)"></div>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent, PropType } from "vue";

import { Tool } from '../interfaces';

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
  width: 41%;
  height: 200px;
  float: left;

  background: var(--white);
  border: 1px solid var(--border);
  border-radius: 0.3em;
  padding: 1em;
  margin: 0 0.5em 1em 0.5em;

  & .tool-info {
    vertical-align: middle;
    height: 100%;
    color: var(--secondary);

    & .tool-title {
      color: var(--main);
    }

    & .tool-description {
      height: 50%;
    }
  }
}
</style>

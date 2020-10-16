<template>
  <form action="">
    <div class="row">
      <input v-model="state.company.name" placeholder="Company Name">
    </div>

    <div class="row">
      <input v-model="state.company.website" placeholder="Company Website">
    </div>

    <div class="row">
      <input v-model="state.company.tools" placeholder="Company Technology Tools">
    </div>

    <div class="row">
      <button type="submit">Submit</button>
    </div>
  </form>
</template>

<script lang="ts">
import { defineComponent, onMounted, reactive } from "vue";

import { Company } from '../interfaces';

export default defineComponent({
  setup() {
    let state = reactive<{ company: Company }> ({
      company: {} as Company,
    })

    return {
      state,
    }
  }
})
</script>

<style scoped>
.row:after {
  content: "";
  display: table;
  clear: both;
}

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

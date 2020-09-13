<template>
  <h1>hey</h1>
  <table class="mail-table">
    <tbody>
      <tr>
        <th>Name</th>
      </tr>

      <tr v-for="company in state.companies">
        <td>{{company.name}}</td>
      </tr>
    </tbody>
  </table>
</template>

<script lang="ts">
import { defineComponent, onMounted, reactive } from "vue";

import CompanyDataService from "./services/CompanyDataService";
import { Company } from './interfaces';

export default defineComponent({
  setup() {
    let state = reactive<{companies: Company[]}>({
      companies: []
    })

    onMounted(() => {
      CompanyDataService.getAll().then((data) => {
        state.companies = data.companies
      });
    });

    return {
      state,
    }
  }
});
</script>

<template>
  <h1>{{state.company.name}}</h1>
  <span><b>Website:</b> {{state.company.website}}</span>
  <br>
  <span><b>Tools:</b> {{state.tools}}</span>
</template>

<script lang="ts">
import { defineComponent, onMounted, computed, reactive } from "vue";
import { useRoute, useRouter } from 'vue-router';

import CompanyDataService from "../services/CompanyDataService";
import { Company } from '../interfaces';

export default defineComponent({
  setup() {
    const route  = useRoute();
    const userId = Number(route.params.id);

    let state = reactive<{company: Company, tools: String}>({
      company: <Company>{},
      tools: '',
    });

    onMounted(() => {
      CompanyDataService.getOne(userId).then((data) => {
        state.company = data.company;
        state.tools   = data.company.tools.map((tool) => {
          return tool.name;
        }).join(', ');
      });
    });

    return {
      state,
    }
  }
});
</script>

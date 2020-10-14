<template>
  <input type="text" placeholder="Search" v-model="searchQuery">
</template>

<script lang="ts">
import { defineComponent, PropType, ref, watch } from "vue";

import { Company } from '../../interfaces';

export default defineComponent({
  props: {
    companies: {
      type: Array as PropType<Array<Company>>,
    },
    paginatedCompanies: {
      type: Array as PropType<Array<Company>>,
    },
  },
  setup(props, { emit }) {
    let searchQuery = ref('');

    watch(searchQuery, (_newValue, _oldValue) => {
      let query: string                = searchQuery.value.toLowerCase();
      let filteredCompanies: Company[] = [];

      if (query != '') {
        filteredCompanies = props.companies!.filter((company: Company) => {
          return company.name.toLowerCase().startsWith(query);
        });
      } else {
        filteredCompanies = props.paginatedCompanies!;
      }

      emit('updateListedBySearch', filteredCompanies);
    });

    return {
      searchQuery,
    }
  }
});
</script>

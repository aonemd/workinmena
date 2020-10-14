<template>
    <button @click="state.page--" :disabled="state.page-1 <= 0">Prev</button>
    {{state.page}}
    <button @click="state.page++">Next</button>
</template>

<script lang="ts">
import { defineComponent, PropType, reactive, watch } from "vue";

import { Company } from '../../interfaces';

export default defineComponent({
  props: {
    companies: {
      type: Array as PropType<Array<Company>>,
    },
  },
  emits: ['updatePaginatedByPaginator'],
  setup(props, { emit }) {
    let state = reactive<{ page: number, perPage: number }>({
      page: 1,
      perPage: 20,
    });

    watch(() => state.page, (_newValue, _oldValue) => {
      let from: number = (state.page * state.perPage) - state.perPage;
      let to: number   = state.page * state.perPage;

      let paginatedCompanies = props.companies!.slice(from, to);

      emit('updatePaginatedByPaginator', paginatedCompanies);
    });

    return {
      state,
    }
  }
});
</script>

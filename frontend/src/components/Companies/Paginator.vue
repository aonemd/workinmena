<template>
  <div id="paginator">
    <button @click="state.page--" :disabled="state.page-1 <= 0">Prev</button>
    {{state.page}}
    <button @click="state.page++" :disabled="state.page >= state.numberOfPages">Next</button>
  </div>
</template>

<script lang="ts">
import { defineComponent, PropType, reactive, computed, ComputedRef, watch } from "vue";

import { Company } from '../../types';

export default defineComponent({
  props: {
    companies: {
      type: Array as PropType<Array<Company>>,
    },
  },
  emits: ['updatePaginatedByPaginator'],
  setup(props, { emit }) {
    let state = reactive<{ page: number, perPage: number, numberOfPages: ComputedRef<number> }>({
      page: 1,
      perPage: 20,
      numberOfPages: computed((): number => {
        return Math.ceil(props.companies!.length / 20);
      }),
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

<style scoped>
#paginator {
  text-align: center;
}
</style>

<template>
  <div id="search">
    <input
      ref="inputElementRef"
      type="search"
      placeholder="Search by company or tool..."
      v-model="searchQuery"
      :disabled="disabled">
  </div>
</template>

<script lang="ts">
import {
  defineComponent,
  PropType,
  ref,
  Ref,
  computed,
  ComputedRef,
  watch,
} from "vue";

import { Company } from '../../types';
import AmplitudeWrapper from '../../services/amplitude-analytics-wrapper.service';

export default defineComponent({
  props: {
    companies: {
      type: Array as PropType<Array<Company>>,
    },
    paginatedCompanies: {
      type: Array as PropType<Array<Company>>,
    },
    disabled: {
      type: Boolean,
      default: false,
    },
  },
  setup(props, { emit }) {
    let inputElementRef                = ref();
    let searchQuery: Ref<string>       = ref('');
    let disabled: ComputedRef<Boolean> = computed((): boolean => {
      return props.disabled;
    });

    watch(disabled, (newValue, _oldValue) => {
      inputElementRef.value.disabled = newValue;
      inputElementRef.value.focus();
    });

    watch(searchQuery, (_newValue, _oldValue) => {
      let query: string                = searchQuery.value.toLowerCase();
      let filteredCompanies: Company[] = [];

      if (query != '') {
        filteredCompanies = props.companies!.filter((company: Company) => {
          return company.name.toLowerCase().startsWith(query) || company.tool_search_pattern.includes(query);
        });

        AmplitudeWrapper.logEvent('company_filter', { query: searchQuery.value });
      } else {
        filteredCompanies = props.paginatedCompanies!;
      }

      emit('updateListedBySearch', filteredCompanies);
    });

    return {
      inputElementRef,
      disabled,
      searchQuery,
    }
  }
});
</script>

<style scoped>
#search {
  float: right;
  clear: both;
  margin-bottom: 10px;

  & input {
    width: 250px;
    border: 1px solid var(--border);
    border-radius: 0.3em;
    padding: 0.7em;
  }
}
</style>

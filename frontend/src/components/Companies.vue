<template>
  <div v-if="state.loading" id="loader">Loading...</div>
  <div v-else>
    <ul id="company-list">
      <li v-for="company in state.paginatedCompanies" v-bind:key="company.name">
        <router-link :to="{ name: 'Company', params: { id: company.id } }">
          <div class="company-info">
            <span class="company-title">{{company.name}}</span>
            <span class="company-details">
              {{company.website}}
              <span class="separator">&bull;</span>
              <span v-if="company.popular_tool">
                Popular for: <b>{{ company.popular_tool.name }}</b>
              </span>
            </span>
          </div>
        </router-link>
      </li>
    </ul>

    <button @click="state.page--" :disabled="state.page-1 <= 0">Prev</button>
    {{state.page}}
    <button @click="state.page++">Next</button>
  </div>
</template>

<script lang="ts">
import { defineComponent, onMounted, reactive, watch, watchEffect } from "vue";

import CompanyDataService from "../services/CompanyDataService";
import { Company } from '../interfaces';

export default defineComponent({
  setup() {
    let state = reactive<{loading: Boolean, companies: Company[], paginatedCompanies: Company[], page: number, perPage: number}>({
      loading: true,
      companies: [],
      paginatedCompanies: [],
      page: 1,
      perPage: 20,
    });

    onMounted(() => {
      CompanyDataService.getLimited(state.perPage).then((data) => {
        state.paginatedCompanies = data.companies;
        state.loading = false;
      });

      CompanyDataService.getAll().then((data) => {
        state.companies = data.companies;
      });
    });

    watchEffect(() => {
      // paginate companies
      let from: number = (state.page * state.perPage) - state.perPage;
      let to: number   = state.page * state.perPage;

      state.paginatedCompanies = state.companies.slice(from, to);
    });

    return {
      state,
    }
  }
});
</script>

<style scoped>
#company-list {
  width: 100%;
  position: relative;
  list-style: none;
  padding: 0;

  & li {
    background: var(--white);
    border: 1px solid var(--border);
    border-radius: 0.3em;
    padding: 1em;
    margin-bottom: 1em;
    position: relative;
    z-index: 1;
    display: table; /* so the elements inside act like table cells so that they can be vertically aligned in the middle */
    width: 96%;

    transition: all 0.3s ease-in-out;
    &:hover {
      cursor: pointer;
      box-shadow: 0px 2px 40px 0 rgba(0, 0, 0, 0.1);
    }

    & .company-info {
      line-height: 1.25em;
      width: 640px;
      padding-left: 25px;

      display: table-cell;
      vertical-align: middle;
      font-size: 0.9em;
      color: var(--secondary);

      & .company-title {
        font-weight: 700;
        font-size: 1.5em;
        color: var(--main);
      }

      & .company-details {
        color: var(--secondary);
        display: block;
        padding-top: 0.4em;

        /* the dot between company-details */
        & span.separator {
          margin: 0 0.75em;
        }
      }
    }
  }
}

#loader {
  text-align: center;
}
</style>

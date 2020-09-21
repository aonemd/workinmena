<template>
  <ul id="company-list">
    <li v-for="company in state.companies" v-bind:key="company.name">
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
</template>

<script lang="ts">
import { defineComponent, onMounted, reactive } from "vue";

import CompanyDataService from "../services/CompanyDataService";
import { Company } from '../interfaces';

export default defineComponent({
  setup() {
    let state = reactive<{companies: Company[]}>({
      companies: []
    });

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
</style>

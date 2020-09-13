import { createRouter, createWebHistory } from 'vue-router';

import Companies from '../components/Companies.vue';
import Company from '../components/Company';

const router = createRouter({
  history: createWebHistory(),
  routes: [
    {
      path: '/',
      name: 'Companies',
      component: Companies,
    },
    {
      path: '/company/:id',
      name: 'Company',
      component: Company,
    }
  ],
});

export default router;

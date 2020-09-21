import { createRouter, createWebHistory } from 'vue-router';

import Companies from '../components/Companies.vue';
import Company from '../components/Company.vue';

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
      props: (route) => {
        return {
          id: Number(route.params.id),
        }
      },
    }
  ],
});

export default router;

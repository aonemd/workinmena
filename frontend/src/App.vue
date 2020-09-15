<template>
  <div class="wrapper">
    <router-link to="/">
      <div class="logo">
        <h1><span>WorkIn</span>MENA<span>.tech</span></h1>
      </div>
    </router-link>

    <router-view />
  </div>
</template>

<script lang="ts">
import { defineComponent, onMounted, reactive } from "vue";

export default defineComponent({
  setup() {}
});
</script>

<style>
@import "assets/stylesheets/variables.css";

body {
  padding-bottom: 5em;

  background-image: none;
  background-color: var(--white);

  font-family: var(--latin-font);
}

a {
  text-decoration: none;
}

.wrapper {
  width: 800px;
  max-width: 90%;
  margin: 0 auto;
}

.logo {
  & h1 {
    float: left;
    margin: 0 0 0 1em;
    text-transform: uppercase;
    font-size: 1.35em;
    padding-top: 1.1em;
    color: var(--main);

    & span {
      font-weight: 400;
    }
  }
}
</style>

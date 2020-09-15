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
:root {
  --white:       #ffffff;
  --main:        #34314c;
  --secondary:   #9592ad;
  --border:      #d9dee9;
  --high-blue:   #45aaf2;
  --highlight-1: #fd7473;  /* red */
  --highlight-2: #fec951;  /* yellow */
  --highlight-3: #47b8e0;  /* blue */
  --highlight-4: #9f68d0;  /* purple */

  --latin-font: 'Open Sans', sans-serif;
}

body {
  padding-bottom: 5em;

  background-image: none;
  background-color: var(--white);

  font-family: var(--latin-font);
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

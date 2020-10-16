<template>
  <div class="wrapper">
    <router-link to="/" class="clearfix">
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

* {
  margin: 0;
  padding: 0;
}

body {
  background-image: none;
  background-color: var(--white);

  font-family: var(--latin-font);
}

footer {
  padding-bottom: 5em;
}

a {
  text-decoration: none;
}

.wrapper {
  padding: 0 10px;
}

@media only screen and (min-width: 640px) {
  .wrapper {
    margin: 0 auto;
    max-width: 40%;
  }
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

.clearfix:before, .clearfix:after {
  content: " ";
  display: table;
}

.clearfix:after {
  clear: both;
}
</style>

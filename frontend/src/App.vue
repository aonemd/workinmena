<template>
  <div class="wrapper">
    <nav class="clearfix">
      <router-link to="/" class="logo">
        <h1><span>WorkIn</span>MENA<span>.tech</span></h1>
      </router-link>

      <div class="menu">
        <router-link :to="{ name: 'AddCompanyForm' }">
          Add Your Company
        </router-link>
      </div>
    </nav>

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

nav {
  margin-bottom: 35px;
  padding-top: 1.1em;

  & .logo {
    float: left;

    & h1 {
      margin: 0 0 0 1em;
      text-transform: uppercase;
      font-size: 1.35em;
      color: var(--main);

      & span {
        font-weight: 400;
      }
    }
  }

  & .menu {
    float: right;
    text-transform: uppercase;
    text-decoration: underline;

    & a {
      color: var(--main);
      font-size: 18px;
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

.row:after {
  content: "";
  display: table;
  clear: both;
}
</style>

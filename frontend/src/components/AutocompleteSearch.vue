<template>
  <div class="autocomplete-search">
    <input
      ref="inputElementRef"
      v-model="state.query"
      @input="handleOnChange"
      :placeholder="state.placeholder">

    <ul v-show="state.isOpen" class="autocomplete-search__filtered-list">
      <li
        v-for="(filteredItem, i) in state.filteredList"
        :key="i"
        class="autocomplete-search__filtered-item">
        <a href="#" @click="confirmSelection(filteredItem)">
          {{ filteredItem.name }}
        </a>
      </li>
    </ul>

    <ul class="autocomplete-search__selected-list">
      <li
        v-for="(selectedItem, i) in state.selectedList"
        :key="i"
        class="autocomplete-search__selected-item">
        <span class="autocomplete-search__selected-item__content">
          {{ selectedItem.name }}
          <span
            @click="removeSelection(i)"
            class="autocomplete-search__selected-item__remove">
            &times;
          </span>
        </span>
      </li>
    </ul>
  </div>
</template>

<script lang="ts">
import { defineComponent, PropType, reactive, ref, watch, onMounted, } from "vue";

import { SearchItem } from '../types';

export default defineComponent({
  props: {
    placeholder: {
      type: String,
      default: 'Search',
    },
    autofocus: {
      type: Boolean,
      default: false,
    },
    clear: {
      type: Boolean,
      default: false,
    },
    searchList: {
      type: Array as PropType<Array<SearchItem>>,
    },
    suggestedList: {
      type: Array as PropType<Array<SearchItem>>,
      default: [],
    }
  },
  setup(props, { emit }) {
    let state = reactive<{
      query: string,
      isOpen: boolean,
      placeholder: string,
      filteredList: SearchItem[],
      selectedList: SearchItem[],
    }>({
      query: '',
      isOpen: false,
      placeholder: props.placeholder,
      filteredList: [],
      selectedList: props.suggestedList.slice(),
    });

    let inputElementRef = ref();
    onMounted(() => {
      if (props.autofocus)
        inputElementRef.value.focus();
    });

    watch(() => props.suggestedList, (_newValue, _oldValue) => {
      state.selectedList.push(..._newValue);
    });

    watch(() => props.clear, (_newValue, _oldValue) => {
      if (props.clear) {
        state.query        = '';
        state.selectedList = [];

        emit('updateSelectedList', state.selectedList);
      }
    });

    function handleOnChange() {
      state.isOpen = true;

      filterSearchList();

      emit('updateSearchQuery', state.query);
    }

    function filterSearchList() {
      state.filteredList = props.searchList!.filter((item: SearchItem): boolean =>  {
        return item.name.toLowerCase().indexOf(state.query.toLowerCase()) > - 1
      });

      if (state.filteredList.length == 0) {
        state.filteredList = [{ id: null, name: state.query }];
      }
    }

    function confirmSelection(selectedItem: SearchItem) {
      if (state.selectedList.indexOf(selectedItem) === -1) {
        state.selectedList.unshift(selectedItem);

        emit('updateSelectedList', state.selectedList);
      }

      state.query  = '';
      state.isOpen = false;

      inputElementRef.value.focus();
    }

    function removeSelection(index: number) {
      state.selectedList.splice(index, 1);

      emit('updateSelectedList', state.selectedList);
    }

    return {
      state,
      inputElementRef,
      handleOnChange,
      confirmSelection,
      removeSelection,
    }
  }
})
</script>

<style scoped>
.autocomplete-search {
  position: relative;
}

.autocomplete-search__filtered-list {
  list-style: none;
  padding: 0;
  margin: 0;
  border: 1px solid #d9dee9;
  height: 120px;
  overflow: auto;
}

.autocomplete-search__filtered-item {
  text-align: left;
  padding: 4px 2px;
  cursor: pointer;

  & a {
    text-decoration: none;
    display: block;
    color: var(--main);

  }

  & a:hover {
    background-color: #34314c;
    color: #ffffff;
  }

  & a:focus {
    background-color: #34314c;
    color: #ffffff;
  }
}

.autocomplete-search__filtered-item:hover {
  background-color: #34314c;
  color: #ffffff;

  & a {
    color: #ffffff;
  }
}

.autocomplete-search__selected-list {
  list-style: none;

  & .autocomplete-search__selected-item {
    display:inline;
    float: left;
    margin-right: 10px;
    margin-top: 20px;

    & .autocomplete-search__selected-item__content {
      padding: 0.4em;
      background-color: #34314c;
      color: #ffffff;
      font-size: 16px;

      & .autocomplete-search__selected-item__remove {
        cursor: pointer;
      }
    }
  }
}

input {
  box-sizing: border-box; /* prevent padding from affecting width */
  width: 100%;
  border: 1px solid #d9dee9;
  border-radius: 0.3em;
  padding: 1em;
  margin-bottom: 2em;
}
</style>

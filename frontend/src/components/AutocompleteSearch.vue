<template>
  <div class="autocomplete-search">
    <input
       v-model="state.query"
       @input="handleOnChange"
       :placeholder="state.placeholder">

    <ul v-show="state.isOpen" class="autocomplete-search__filtered-list">
      <li
        v-for="(filteredItem, i) in state.filteredList"
        :key="i"
        @click="confirmSelection(filteredItem)"
        class="autocomplete-search__filtered-item">
        {{ filteredItem.name }}
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
import { defineComponent, PropType, reactive, watch } from "vue";

import { SearchItem } from '../interfaces';

export default defineComponent({
  props: {
    placeholder: {
      type: String,
      default: 'Search',
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
    }

    function filterSearchList() {
      state.filteredList = props.searchList!.filter((item: SearchItem): boolean =>  {
        return item.name.toLowerCase().indexOf(state.query.toLowerCase()) > - 1
      });

      if (state.filteredList.length == 0) {
        state.filteredList = [{ id: null, name: state.query }];
      }
    }

    function confirmSelection(result: SearchItem) {
      state.selectedList.push(result);

      state.query  = '';
      state.isOpen = false;

      emit('updateSelectedList', state.selectedList);
    }

    function removeSelection(index: number) {
      state.selectedList.splice(index, 1);

      emit('updateSelectedList', state.selectedList);
    }

    return {
      state,
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
}

.autocomplete-search__filtered-item:hover {
  background-color: #34314c;
  color: #ffffff;
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

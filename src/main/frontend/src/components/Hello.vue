<template>
  <div class="hello">
    <input v-model='name'> <button v-on:click='requestGreeting'>Send</button>
    <p>Your client side name is {{ name }}</p>
    <p>The server API says: {{ greeting }}</p>
    <span v-if='error' class='error'>{{ error.message }}</span>
  </div>
</template>

<script>
  import axios from 'axios'
  
  export default {
    name: 'hello',
    data () {
      return {
        name: null,
        greeting: '<nothing so far>',
        error: ''
      }
    },
    methods: {
      requestGreeting: function () {
        var vm = this
        axios.get('/api/hello', {
          params: {
            name: vm.name
          }
        }).then(function (response) {
          vm.error = null
          vm.greeting = response.data
        }).catch(function (error) {
          vm.error = error
          console.log(error)
        })
      }
    }
  }
</script>

<style scoped>
  h1, h2 {
    font-weight: normal;
  }

  ul {
    list-style-type: none;
    padding: 0;
  }

  li {
    display: inline-block;
    margin: 0 10px;
  }

  a {
    color: #42b983;
  }

  .error {
    color: red;
    background-color: lightGrey;
    padding: 5px;
  }
</style>

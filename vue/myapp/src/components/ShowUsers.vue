<template>
<div id="users">
  <div v-for="(user, index) in users" :key="user.id">
   <p>{{user.name}} my phone number: {{user.phoneNumber}}</p>
  </div>
 </div>
</template>
<script>

//This works!!! - DO NOT DELETE
/*const axios = require('axios');
var user;
async function getUsers(){
  const response = await axios.get('http://localhost:3000/users');
  user = response.data;
  console.log(user)
}

getUsers();*/

/*axios.get('http://localhost:3000/users')
  .then(function(response){
    console.log(response)
  })
  .catch(function (error) {
    // handle error
    console.log(error);
  })
  .finally(function () {
    // always executed
  });*/

import axios from 'axios';

export default {
  data() {
    return {
      users: [],
      errors: [],
    }
  },

  created(){
    axios.get('http://localhost:3000/users')
      .then(response => {
        this.users = response.data
      })
      .catch(e => {
        this.errors.push(e)
      })
  }
}
</script>

<template>
  <div id="users">

    <div>
      Name: <input v-model="name" placeholder="123">
      Local: <input v-model="local" placeholder="123">
      <button id="btn" class="" v-on:click="getUserNameLocal(name,local)">Search</button>
    </div>

    <div v-for="(user, index) in users" :key="user.id">
      <p>{{user.name}} my phone number: {{user.phoneNumber}} and counter: {{user.counter}}</p>
    </div>

    <!--<div  style="float:right;">
      <GmapMap
      :center="{lat:42, lng:-8}"
      :zoom="7"
      map-type-id="terrain"
      style="width: 500px; height: 300px"
      >
      <GmapMarker
      :key="index"
      v-for="(m, index) in markers"
      :position="m.position"
      :clickable="true"
      :draggable="true"
      @click="center=m.position"
      />
    </GmapMap>
  </div>-->

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
  mounted() {
    console.log('Component mounted.')
  },
  data() {
    return {
      users: [],
      errors: [],
    }
  },
  methods:{
    created(){
      axios.get('http://localhost:3000/users')
      .then(response => {
        this.users = response.data
      })
      .catch(e => {
        this.errors.push(e)
      })
    },
    getUserNameLocal(name,local){
      var url = 'http://localhost:3000/users/';
      if(name && local){
        url = url + 'name/'+name+'/local/'+local;
      }else if (name && !local) {
        url = url + 'name/'+name;
      }else if (!name && local) {
        url = url + 'local/'+local;
      }
      console.log(url);
      axios.get(url)
      .then(response => {
        this.users = response.data
      })
      .catch(e => {
        this.errors.push(e)
      })
    },

    updateCounter(id){
      var url = 'http://localhost:3000/users/updateCounter/'+id;
      axios.patch(url)
    },


  }
}
</script>

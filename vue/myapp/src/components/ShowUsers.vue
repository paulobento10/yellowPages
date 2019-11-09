<template>
  <div>
    <div style="background:transparent !important" class="jumbotron">
      <fieldset class="border border-dark">
        <legend id="Legend5" runat="server" visible="true" style="width:auto; margin-bottom:0px; margin-left:40px; font-size:20px; font-weight:bold;">Inserir Nova Empresa</legend>
        <b-container fluid style="margin-left:175px;">
          <b-row class="my-1">
            <b-col sm="0">
              <label for="input-small">Nome:</label>
            </b-col>
            <b-col sm="4">
              <b-form-input id="input-small" size="sm" v-model="name" placeholder="Nome da Empresa"></b-form-input>
            </b-col>
            <b-col sm="0">
              <label for="input-small">Morada:</label>
            </b-col>
            <b-col sm="4">
              <b-form-input id="input-small" size="sm" v-model="local" placeholder="Local da Empresa"></b-form-input>
            </b-col>
            <b-col sm="3">
              <b-button variant="outline-primary" v-on:click="getUserNameLocal(name,local); updateCounter(users)">Pesquisar</b-button>
            </b-col>
          </b-row>
        </b-container>
      </fieldset>
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
      });
    },

    updateCounter(users){
      users.forEach(element => {
        var url = 'http://localhost:3000/users/updateCounter/'+element.id;
        axios.patch(url)
      });
    },


  }
}
</script>

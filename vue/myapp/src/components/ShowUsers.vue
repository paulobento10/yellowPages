<template>
  <div>
    <div style="background:transparent !important" class="jumbotron">
      <fieldset class="border border-dark">
        <legend id="Legend5" runat="server" visible="true" style="width:auto; margin-bottom:0px; margin-left:40px; font-size:20px; font-weight:bold;">Pesquisa</legend>
        <b-container fluid style="margin-left:20px;">
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
              <b-button variant="outline-primary" v-on:click="getUserNameLocal(name,local); updateCounter(users);">Pesquisar</b-button>
            </b-col>
          </b-row>
        </b-container>
      </fieldset>

      <fieldset class="border border-dark">
        <legend id="Legend5" runat="server" visible="true" style="width:auto; margin-bottom:0px; margin-left:40px; font-size:20px; font-weight:bold;">Resultados Mais Pesquisados</legend>
          <b-col align-self="center">
            <b-carousel
              id="carousel-1"
              v-model="slide"
              :interval="4000"
              controls
              indicators
              background="#ababab"
              img-width="306"
              img-height="120"
              style="text-shadow: 1px 1px 2px #333;"
              @sliding-start="onSlideStart"
              @sliding-end="onSlideEnd">

            <b-carousel-slide img-src="https://www.firstderivatives.com/wp-content/uploads/2016/02/companyProfileBanner.jpg"  caption="#1 Mais Pequisado">
              <h1>{{ mostSearchedUsers[0].name }}</h1> <!--No lugar de users, usamos o array de mostSearchedUsers-->
            </b-carousel-slide>

            <b-carousel-slide img-src="https://www.firstderivatives.com/wp-content/uploads/2016/02/companyProfileBanner.jpg" caption="#2 Mais Pequisado">
              <h1>{{ mostSearchedUsers[1].name }}</h1> <!--No lugar de users, usamos o array de mostSearchedUsers-->
            </b-carousel-slide>

            <b-carousel-slide img-src="https://www.firstderivatives.com/wp-content/uploads/2016/02/companyProfileBanner.jpg" caption="#3 Mais Pequisado">
              <h1>{{ mostSearchedUsers[2].name }}</h1> <!--No lugar de users, usamos o array de mostSearchedUsers-->
            </b-carousel-slide>
          </b-carousel>
          </b-col>
      </fieldset>
    </div>

    <div style="background:transparent !important" class="jumbotron">
      <b-row>
        <b-col cols="7" v-for="(user, index) in users" :key="user.id">
          <span style="font-weight: bold;">Nome/Morada/Telefone<br></span>
          <span>{{user.name}}<br></span>
          <span>{{user.address}}<br></span>
          <span>{{user.postalCode}},{{user.local}}<br></span>
          <span>{{user.phoneNumber}}<br><br></span>
        </b-col>

        <b-col cols="5">
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
        </b-col>
      </b-row>
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
    this.created()
    //this.getMostSearchedUsers   //chamar função para preencher o array "mostSearchedUsers"
  },
  data() {
    return {
      users: [],
      mostSearchedUsers: [],
      errors: [],
    }
  },
  methods:{
    created(){
      axios.get('http://localhost:3000/users')
      .then(response => {
        this.users = response.data
        this.mostSearchedUsers = response.data //Só para testar
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

    getMostSearchedUsers(){
      //depois de fazer esta função -> eliminar linha 157
    }

  }
}
</script>

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
              <b-button variant="outline-primary" v-on:click="getUserNameLocal(name, local, currentPage, perPage); updateCounter(users);">Pesquisar</b-button>
            </b-col>
          </b-row>
        </b-container>
      </fieldset>

      <fieldset class="border border-dark">
        <legend id="Legend5" runat="server" visible="true" style="width:auto; margin-bottom:0px; margin-left:40px; font-size:20px; font-weight:bold;">Top 3 Mais Pesquisados</legend>
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
        <b-col cols="7" v-for="(user, index) in users" :key="user.id" style="borderBottom:3px solid">
          <span style="font-weight: bold;">Nome/Morada/Telefone<br></span>
          <span>{{user.name}}<br></span>
          <span>{{user.address}}<br></span>
          <span>{{user.postalCode}},{{user.local}}<br></span>
          <span>{{user.phoneNumber}}<br></span>
          <a v-bind:href='user.link'>{{user.link}}</a>
          <span><br></span>
        </b-col>
        <div class="container">
        <button style="float:left; background-color: white; color: black; border: 1px solid #555555;" v-on:click="getUsersOffsetDelta(name,local,(currentPage-1),perPage);">
              Anterior
        </button>
        <div class="container" v-for="i in Math.ceil(len/3)">
          <!-- <ul class="pagination" > -->
            <!--<li style="float:left" v-for="i in Math.ceil(len/3)"><button style="float:left" id="btnPage" class="" v-on:click="getUsersOffsetDelta(parseInt(i),3)"></button> </li> <!-- <a href="#">1</a> -->
            <button style="float:left; background-color: white; color: black; border: 1px solid #555555;" v-on:click="getUsersOffsetDelta(name,local,parseInt(i),perPage);">
              {{i}}
            </button>
          <!--</ul>-->
        </div>
        <button style="float:left; background-color: white; color: black; border: 1px solid #555555;" v-on:click="getUsersOffsetDelta(name,local,(currentPage+1),perPage);" >
              Próxima
        </button>
      </div>
      </b-row>
      <b-col md="4" offset-md="8">
          <GmapMap
            :center="{lat:42, lng:-8}"
            :zoom="7"
            map-type-id="terrain"
            style="width: 500px; height: 300px">
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
  mounted() {
    console.log('Component mounted.')
    this.created()
    this.getMostSearchedUsers()
    this.getUsersOffsetDeltaBegin(this.currentPage,this.perPage)
  },
  data() {
    return {
      perPage: 3,
      currentPage: 1,
      len: 0,
      auxName: '',
      auxLocal: '',
      allUsers: [],
      users: [],
      mostSearchedUsers: [],
      errors: [],
    }
  },
  methods:{
    created(){
      var self = this
      const url = 'http://localhost:3000/users'
      axios.get(url, {
        dataType: 'json',
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        mode: 'no-cors',
        credentials: 'include'
      })
      .then(function(response) {
        console.log(JSON.stringify(response.data))
        self.allUsers = response.data
        self.len = self.allUsers.length;
      })
      .catch(function(error) {
        console.log(error)
      })
    },

    getUserNameLocal(name, local, offset, delta){
      var url = 'http://localhost:3000/users/';
      if(name && local){
        url = url + 'likeName/'+name+'/likeLocal/'+local+'/offset/'+(offset-1)+'/delta/'+delta;
      }else if (name && !local) {
        
        url = url + 'likeName/'+name+'/offset/'+(offset-1)+'/delta/'+delta;
      }else if (!name && local) {
        
        url = url + 'likeLocal/'+local+'/offset/'+(offset-1)+'/delta/'+delta;
      }
      console.log(url);
      axios.get(url)
      .then(response => {
        this.users = response.data
        this.len = this.users.length
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

    getUsersOffsetDelta: function(name, local, offset,delta){
      var url = 'http://localhost:3000/users/';
      console.log('OFFSET: '+offset);
      if(offset<=(Math.ceil(this.users.length/3)) && offset>0 || offset==currentPage){
        this.currentPage=offset
      }
      if(name && local){
        var self = this
        url = url + 'likeName/'+name+'/likeLocal/'+local+'/offset/'+(offset-1)+'/delta/'+delta;
        console.log('url showOffsetDelta: '+url);
      }else if (name && !local) {
        var self = this
        url = url + 'likeName/'+name+'/offset/'+(offset-1)+'/delta/'+delta;
        console.log('url showOffsetDelta: '+url);
      }else if (!name && local) {
        var self = this
        url = url + 'likeLocal/'+local+'/offset/'+(offset-1)+'/delta/'+delta;
        console.log('url showOffsetDelta: '+url);
      }else if(!name && !local) {
        var self = this
        url = url + '/offset/'+(offset-1)+'/delta/'+delta;
        console.log('url showOffsetDelta: '+url);
      }
      axios.get(url, {
          dataType: 'json',
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
          },
          mode: 'no-cors',
          credentials: 'include'
        })
        .then(function(response) {
          console.log(JSON.stringify(response.data))
          self.users = response.data
        })
        .catch(function(error) {
          console.log(error)
        })
    },

    getUsersOffsetDeltaBegin: function(offset,delta){
      var self = this
      const url = 'http://localhost:3000/users/offset/'+(offset-1)+'/delta/'+delta
      console.log('url showOffsetDelta: '+url);
      axios.get(url, {
        dataType: 'json',
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        mode: 'no-cors',
        credentials: 'include'
      })
      .then(function(response) {
        console.log(JSON.stringify(response.data))
        self.users = response.data
        //document.getElementById(offset.toString()).innerHTML = offset
      })
      .catch(function(error) {
        console.log(error)
      })
    },

    getMostSearchedUsers(){
      var self = this
      const url = 'http://localhost:3000/users/limit/3'
      axios.get(url, {
        dataType: 'json',
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        mode: 'no-cors',
        credentials: 'include'
      })
      .then(function(response) {
        console.log(JSON.stringify(response.data))
        self.mostSearchedUsers = response.data
      })
      .catch(function(error) {
        console.log(error)
      })
    }
  }
}
</script>

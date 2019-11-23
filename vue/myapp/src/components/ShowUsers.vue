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
              <b-button pill v-on:click="getUsersOffsetDelta(name, local, 1, perPage);">Pesquisar</b-button>
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
              <h1>{{ mostSearchedUsers[0].name }}</h1>
            </b-carousel-slide>

            <b-carousel-slide img-src="https://www.firstderivatives.com/wp-content/uploads/2016/02/companyProfileBanner.jpg" caption="#2 Mais Pequisado">
              <h1>{{ mostSearchedUsers[1].name }}</h1>
            </b-carousel-slide>

            <b-carousel-slide img-src="https://www.firstderivatives.com/wp-content/uploads/2016/02/companyProfileBanner.jpg" caption="#3 Mais Pequisado">
              <h1>{{ mostSearchedUsers[2].name }}</h1> 
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
          <span>{{user.postalCode}}, {{user.local}}<br></span>
          <span>{{user.phoneNumber}}<br></span>
          <a v-bind:href='user.link'>{{user.link}}</a>
          <span><br></span>
        </b-col>
        <div class="container">
        <button style="float:left; background-color: white; color: black; border: 1px solid #555555;" v-on:click="getUsersOffsetDelta(name,local,(currentPage-1),perPage);">
              Anterior
        </button>
        <b-col v-for="i in Math.ceil(len/3)">
          <!-- <ul class="pagination" > -->
            <!--<li style="float:left" v-for="i in Math.ceil(len/3)"><button style="float:left" id="btnPage" class="" v-on:click="getUsersOffsetDelta(parseInt(i),3)"></button> </li> <!-- <a href="#">1</a> -->
            <button style="float:left; background-color: white; color: black; border: 1px solid #555555;" v-on:click="getUsersOffsetDelta(name,local,parseInt(i),perPage);">
              {{i}}
            </button>
          <!--</ul>-->
        </b-col>
        <button style="float:left; background-color: white; color: black; border: 1px solid #555555;" v-on:click="getUsersOffsetDelta(name,local,(currentPage+1),perPage);" >
              Próxima
        </button>
      </div>
      </b-row>
      <p><br></p>
      <b-row class="justify-content-md-center">
        <b-col cols="12" md="auto">
          <yandex-map 
            :coords="[41.1579438, -8.6291053]"
            zoom="10"
            style="width: 600px; height: 600px;"
            :cluster-options="{
              1: {clusterDisableClickZoom: false}
            }"
            :controls="['trafficControl']"
            :placemarks="placemarks" 
            map-type="hybrid"
            @map-was-initialized="initHandler"
          >
              <!--Com erros! (Ao mudar de página, não aparecem mais markers)-->
              <ymap-marker 
                marker-type="placemark"
                :coords="[latitude1, longitude1]"
                hint-content="Empresa 1"
                
                :icon="{color: 'green', glyph: 'Pocket'}"
                cluster-name="1"
              >
              </ymap-marker>
              <ymap-marker
                marker-type="placemark"
                :coords="[latitude2, longitude2]"
                hint-content="Empresa 2"
                
                :icon="{color: 'green', glyph: 'Pocket'}"
                cluster-name="1"
              >
              </ymap-marker>
              <ymap-marker 
                marker-type="placemark"
                :coords="[latitude3, longitude3]"
                hint-content="Empresa 3"
                
                :icon="{color: 'green', glyph: 'Pocket'}"
                cluster-name="1"
              >
              </ymap-marker>
          </yandex-map>
        </b-col>
      </b-row>
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
    this.getUsers()
    this.getMostSearchedUsers()
    this.getUsersOffsetDeltaBegin(this.currentPage,this.perPage)
  },

  data() {
    return {
      perPage: 3,
      currentPage: 1,
      len: 0,
      name: '',
      local: '',
      latitude1: 90, 
      longitude1: 0,
      latitude2: 90, 
      longitude2: 0,
      latitude3: 90, 
      longitude3: 0,
      allUsers: [],
      users: [],
      mostSearchedUsers: [],
      errors: [],
      placemarks: [
        {
          coords: [90, 0],
          properties: {}, // define properties here
          options: {}, // define options here
          clusterName: "1",
          callbacks: { click: function() {} }
        }
      ]
    }
  },

  methods:{
    getCoords: function() {
      if(this.users.length==1){
        this.latitude1=this.users[0].latitude
        this.longitude1=this.users[0].longitude
        this.latitude2=90
        this.longitude2=0
        this.latitude3=90
        this.longitude3=0
      }
      else if(this.users.length==2){
        this.latitude1=this.users[0].latitude
        this.longitude1=this.users[0].longitude
        this.latitude2=this.users[1].latitude
        this.longitude2=this.users[1].longitude
        this.latitude3=90
        this.longitude3=0
      }
      else if(this.users.length==3){
        console.log('lat: '+this.users[0].latitude+' /lon: '+this.users[0].longitude)
        this.latitude1=this.users[0].latitude
        this.longitude1=this.users[0].longitude
        this.latitude2=this.users[1].latitude
        this.longitude2=this.users[1].longitude
        this.latitude3=this.users[2].latitude
        this.longitude3=this.users[2].longitude
      }
    },

    updateCounter(users){
      users.forEach(element => {
        var url = 'http://localhost:3000/users/updateCounter/'+element.id;
        axios.patch(url)
      });
    },

    getUsers: function() {
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
        console.log('ALL USERS: '+JSON.stringify(response.data))
        self.allUsers = response.data
        self.len = self.allUsers.length;
      })
      .catch(function(error) {
        console.log(error)
      })
    },

    getUsersLength(url){
      var self = this
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
        self.len = response.data
        console.log('LEN: '+self.len)
      })
      .catch(function(error) {
        console.log(error)
      })
    },

    getUsersOffsetDelta: function(name, local, offset, delta){
      var self = this
      console.log('name: '+name+' /local: '+local+' /len: '+self.len)
      var url = 'http://localhost:3000/users/';
      if(offset<=(Math.ceil(self.len/3)) && offset>0 || offset==self.currentPage){
        self.currentPage=offset
      }
      if(offset>(Math.ceil(self.len/3))){
        offset=offset-1
      }
      console.log('OFFSET: '+offset+'Current: '+self.currentPage+'Delta:'+delta);

      if(name && local){
        url = url + 'likeName/'+name+'/likeLocal/'+local+'/offset/'+(offset-1)+'/delta/'+delta;
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
          console.log('Search:'+JSON.stringify(response.data))
          self.users = response.data
          var urlSize = 'http://localhost:3000/users/likeName/'+name+'/likeLocal/'+local
          self.getCoords()
          self.getUsersLength(urlSize)
          self.updateCounter(self.users);
        //self.updateTable();
        })
        .catch(function(error) {
          console.log(error)
        })
      }else if (name && !local) {
        url = url + 'likeName/'+name+'/offset/'+(offset-1)+'/delta/'+delta;
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
          console.log('Search:'+JSON.stringify(response.data))
          self.users = response.data
          var urlSize = 'http://localhost:3000/users/likeName/'+name
          self.getCoords()
          self.getUsersLength(urlSize)
          self.updateCounter(self.users);
        //self.updateTable();
        })
        .catch(function(error) {
          console.log(error)
        })
      }else if (!name && local) {
        url = url + 'likeLocal/'+local+'/offset/'+(offset-1)+'/delta/'+delta;
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
          console.log('Search:'+JSON.stringify(response.data))
          self.users = response.data
          var urlSize = 'http://localhost:3000/users/likeLocal/'+local
          self.getCoords()
          self.getUsersLength(urlSize)
          self.updateCounter(self.users);
        //self.updateTable();
        })
        .catch(function(error) {
          console.log(error)
        })
      }else if(!name && !local) {
        url = url + 'offset/'+(offset-1)+'/delta/'+delta;
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
          console.log('Search:'+JSON.stringify(response.data))
          self.users = response.data
          self.getCoords()
          //self.updateTable();
        })
        .catch(function(error) {
          console.log(error)
        })
      }
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
        self.getCoords()
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

<template>
  <div>
    <div style="background:transparent !important" class="jumbotron">
      <fieldset class="border border-dark">
        <legend id="Legend5" runat="server" visible="true" style="width:auto; margin-bottom:0px; margin-left:40px; font-size:20px; font-weight:bold;">Inserir Nova Empresa</legend>
        <div class="mt-2 col-md-12">

          <b-form form id="app" @submit="postPost" method="postPost">
            <p v-if="errors.length">
              <b>Please correct the following error(s):</b>
              <ul>
                <li v-for="error in errors">{{ error }}</li>
              </ul>
            </p>

            <div class="row">
              <div class="col">
                <b-form-group id="input-group-2" label="Nome:" label-for="input-2">
                  <b-form-input id="name" v-model="name" required name="name" placeholder="Nome"></b-form-input>
                </b-form-group>
              </div>
              <div class="col">
                <b-form-group id="input-group-2" label="Telefone:" label-for="input-2">
                  <b-form-input id="phoneNumber" v-model="phoneNumber" required name="phoneNumber" type="number" placeholder="Telefone"></b-form-input>
                </b-form-group>
              </div>
            </div>

            <b-form-group id="input-group-2" label="Morada:" label-for="input-2">
              <b-form-input id="address" v-model="address" required name="address" placeholder="Morada"></b-form-input>
            </b-form-group>

            <div class="row">
              <div class="col">
                <b-form-group id="input-group-2" label="Local:" label-for="input-2">
                  <b-form-input id="local" v-model="local" required name="local" placeholder="Local"></b-form-input>
                </b-form-group>
              </div>

              <div class="col">
                <b-form-group id="input-group-2" label="Código Postal:" label-for="input-2">
                  <b-form-input id="postalCode" v-model="postalCode" required name="postalCode" placeholder="Código Postal"></b-form-input>
                </b-form-group>
              </div>
            </div>

            <div class="row">
              <div class="col">
                <b-form-group id="input-group-2" label="Latitude:" label-for="input-2">
                  <b-form-input id="latitude" v-model="latitude" required name="latitude" placeholder="Latitude"></b-form-input>
                </b-form-group>
              </div>
              <div class="col">
                <b-form-group id="input-group-2" label="Longitude:" label-for="input-2">
                  <b-form-input id="longitude" v-model="longitude" required name="longitude" placeholder="Longitude"></b-form-input>
                </b-form-group>
              </div>
            </div>

            <div class="row">
              <div class="col">
                <b-form-group id="input-group-2" label="Site:" label-for="input-2">
                  <b-form-input id="link" v-model="link" required name="link" placeholder="Site"></b-form-input>
                </b-form-group>
              </div>
            </div>
            <b-button type="reset" variant="danger" class="btn-lg" style="float: right">Reset</b-button>
            <b-button type="submit" variant="primary" class="btn-lg" style="float: right">Criar</b-button>

          </b-form>
          <p><br><br></p>
        </div>
      </fieldset>
    </div>

    <div style="background:transparent !important" class="jumbotron">
      <fieldset class="border border-dark">
        <legend id="Legend5" runat="server" visible="true" style="width:auto; margin-bottom:0px; margin-left:40px; font-size:20px; font-weight:bold;">Editar/Apagar</legend>

        <table id="my-table" class="table table-bordered table-striped table-sm" border style="width:100%">
          <thead>
            <tr>
              <th>
                Nome
              </th>
              <th>
                Morada
              </th>
              <th>
                Código Postal
              </th>
              <th>
                Local
              </th>
              <th>
                Editar
              </th>
              <th>
                Apagar
              </th>
            </tr>
          </thead>
          <tr id="my-table" v-for="user in users">
            <td>{{ user.name }}</td>
            <td>{{ user.address }}</td>
            <td>{{ user.postalCode }}</td>
            <td>{{ user.local }}</td>
            <td>
              <button id="btn" v-on:click="saveUser(user); $bvModal.show('bv-modal-example')">Editar</button>
              <b-modal id="bv-modal-example" hide-footer>
                <template v-slot:modal-title>
                  A Editar {{userForm.name}}
                </template>
                <div class="d-block text-center">
                  <b-form form id="app" @submit="patchNameAddress" method="patchNameAddress">
                    <div class="col">
                      <b-form-group id="fieldset-horizontal" label-cols-sm="4" label-cols-lg="3" label="Nome:" label-for="input-horizontal"> 
                        <b-form-input id="nameEdit" v-model="nameEdit" required name="nameEdit" placeholder="Nome"></b-form-input>
                      </b-form-group>
                    </div>
                    <div class="col">
                      <b-form-group id="fieldset-horizontal" label-cols-sm="4" label-cols-lg="3" label="Morada:" label-for="input-horizontal">
                        <b-form-input id="addressEdit" v-model="addressEdit" required name="addressEdit" placeholder="Morada"></b-form-input>
                      </b-form-group>
                    </div>

                    <b-button type="submit" variant="primary" class="btn-lg" style="float: right" @click="$bvModal.hide('bv-modal-example')">Editar</b-button>
                    <b-button class="btn-lg" style="float: right" @click="$bvModal.hide('bv-modal-example')">Sair</b-button>
                  </b-form>
                </div>
              </b-modal>
            </td>
            <td>
              <button id="btn" v-on:click="deleteUser(user.id);" onClick="window.location.reload();">Apagar</button>
            </td>
          </tr>
        </table>

        <div class="container">
          <button style="float:left; background-color: white; color: black; border: 1px solid #555555;" v-on:click="getUsersOffsetDelta((currentPage-1),3);">
                Anterior
          </button>
          <div class="container" v-for="i in Math.ceil(len/3)">
            <button style="float:left; background-color: white; color: black; border: 1px solid #555555;" v-on:click="getUsersOffsetDelta(parseInt(i),3);">
                {{i}}
              </button>
          </div>
          <button style="float:left; background-color: white; color: black; border: 1px solid #555555;" v-on:click="getUsersOffsetDelta((currentPage+1),3);" >
                Próxima
          </button>
        </div>
      <p><br></p>
      </fieldset>
    </div>

  </div>
</template>

<script>
import axios from 'axios';
export default {
  name: 'course-list-row',
  mounted() {
    this.getUsers()
    this.getUsersOffsetDeltaBegin(this.currentPage,this.perPage)
    console.log('Component mounted.')
  },
  data() {
    return {
      perPage: 3,
      currentPage: 1,
      name: '',
      phoneNumber: '',
      address: '',
      postalCode: '',
      local: '',
      link: '',
      latitude: '',
      longitude: '',
      counter: 0,
      nameEdit: '',
      addressEdit: '',
      len: 0,
      errors: [],
      users: [],
      userForm:null,
      allUsers: [],
    }
  },
  computed: {
    rows() {
      return this.allUsers.length
    },
  },
  methods: {
    patchNameAddress(e)
    {
      console.log('userID:'+this.userForm.id);
      
      e.preventDefault();
      let self = this;
      axios.patch('http://localhost:3000/users/editForm/'+this.userForm.id, { 
        name: this.nameEdit,
        address: this.addressEdit,
      }, {
        headers: {
          'Content-Type': 'application/json'
        }
      }, )
      .then(function(response) {
        console.log(response);
        const status = JSON.parse(response.status);
        if (status == '201') {
          self.$router.push('show');
        }
        window.location.reload();
      })
      .catch(e => {
        this.errors.push(e)
      })
    },
    // Pushes posts to the server when called.
    postPost(e) {
      e.preventDefault();
      let self = this;
      axios.post('http://localhost:3000/users', {
        name: this.name,
        phoneNumber: this.phoneNumber,
        address: this.address,
        postalCode: this.postalCode,
        local: this.local,
        link: this.link,
        counter: this.counter,
        latitude: this.latitude,
        longitude: this.longitude
      }, {
        headers: {
          'Content-Type': 'application/json'
        }
      }, )
      .then(function(response) { 
        console.log(response);
        const status = JSON.parse(response.status);
        if (status == '201') {
          self.$router.push('show');
        }
      })
      .catch(e => {
        this.errors.push(e)
      })
    },

    //Function to get coordinates from address (Not Working 100%)
    /*getCoords: function() {
      console.log('Getting Coords!!!');
      let self = this;
      const urlCoord = 'https://eu1.locationiq.com/v1/search.php?key=8a5bfd04ea0bc7&q='+self.address+','+self.postalCode+','+self.local+'&format=json'
      axios.get(urlCoord, {
        dataType: 'json',
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        mode: 'no-cors',
        credentials: 'include'
      })
      .then(function(response) {
        self.coordinates = response.data
        self.latitude = self.coordinates[0].lat
        self.longitude = self.coordinates[0].lon
        console.log('latFun:'+self.latitude);
      })
      .catch(function(error) {
        console.log(error)
      })
    },*/
    
    //get users to populate the table
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
        console.log(JSON.stringify(response.data))
        self.allUsers = response.data
        self.len = self.allUsers.length;
      })
      .catch(function(error) {
        console.log(error)
      })
    },
    getUsersOffsetDelta: function(offset,delta){
      console.log('OFFSET: '+offset);
      if(offset<=(Math.ceil(this.allUsers.length/3)) && offset>0 || offset==currentPage){
        this.currentPage=offset
      }
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
      })
      .catch(function(error) {
        console.log(error)
      })
    },
    deleteUser(userId){
      let self = this
      axios.delete('http://localhost:3000/users/'+userId).then(function(response) {
        console.log(response);
      const status = JSON.parse(response.status);
        if (status == '204') {
          self.$router.push('insert');
        }
      });
    },
    saveUser(user){
      this.currentId=user.id;
      this.userForm=user
      console.log(this.userForm);
      
    }
  }
}
</script>
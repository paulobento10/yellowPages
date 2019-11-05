<template>
  <div>
    <div style="background:transparent !important" class="jumbotron">
      <fieldset class="border border-dark">
        <legend id="Legend5" runat="server" visible="true" style="width:auto; margin-bottom:0px; margin-left:40px; font-size:20px; font-weight:bold;">Inserir Nova Empresa</legend>
        <div class="mt-2 col-md-12">

          <b-form form id="app" @submit="postPost" method="postPost">
          <!--<form enctype="multipart/form-data">-->
            <!--<b-form id="app" @submit="postPost" method="postPost" action="http://localhost:3000/users">          action="http://localhost:3000/users"-->
            <p v-if="errors.length">
              <b>Please correct the following error(s):</b>
              <ul>
                <li v-for="error in errors">{{ error }}</li>
              </ul>
            </p>

            <div class="row">
              <div class="col">
                <b-form-group id="input-group-2" label="Your Name:" label-for="input-2">
                  <b-form-input id="name" v-model="name" required name="name" placeholder="Enter name"></b-form-input>
                </b-form-group>
              </div>
              <div class="col">
                <b-form-group id="input-group-2" label="Your Phone Number:" label-for="input-2">
                  <b-form-input id="phoneNumber" v-model="phoneNumber" required name="phoneNumber" type="number" placeholder="Enter phone number"></b-form-input>
                </b-form-group>
              </div>
            </div>

            <b-form-group id="input-group-2" label="Your Address:" label-for="input-2">
              <b-form-input id="address" v-model="address" required name="address" placeholder="Enter address"></b-form-input>
            </b-form-group>

            <div class="row">
              <div class="col">
                <b-form-group id="input-group-2" label="Your Local:" label-for="input-2">
                  <b-form-input id="local" v-model="local" required name="local" placeholder="Enter local"></b-form-input>
                </b-form-group>
              </div>

              <div class="col">
                <b-form-group id="input-group-2" label="Your Postal Code:" label-for="input-2">
                  <b-form-input id="postalCode" v-model="postalCode" required name="postalCode" placeholder="Enter postal code"></b-form-input>
                </b-form-group>
              </div>
            </div>

<<<<<<< HEAD

            <b-form-group id="input-group-2" label="Your Address:" label-for="input-2">
              <input type='file' name='image'/> 
            </b-form-group>
=======
            <div class="row">
              <div class="col">
                <b-form-group id="input-group-2" label="Your Link:" label-for="input-2">
                  <b-form-input id="link" v-model="link" required name="link" placeholder="Enter link"></b-form-input>
                </b-form-group>
              </div>

              <div class="col">
                <b-form-group id="input-group-2" label="Image:" label-for="input-2">
                  <!--<input type="file" accept="image/*" @change="uploadImage($event)" id="file-input">-->
                  <input type="file" id="image" name="image" placeholder="Enter image">
                  <!--<input ref="image" type="file" @change="onFilesChange"
                    data-direct-upload-url="/rails/active_storage/direct_uploads"
                    direct_upload="true" multiple />-->
                </b-form-group>
              </div>
            </div>
>>>>>>> d43462e55b6700e7fd68c3c8b18b63ef1c83d1e3

            <b-button type="reset" variant="danger" class="btn-lg" style="float: right">Reset</b-button>
            <b-button type="submit" variant="primary" class="btn-lg" style="float: right">Criar</b-button>

           </b-form><!--</form>-->
          <p><br><br></p>
        </div>
      </fieldset>
    </div>

    <div class="course-list-row">
      <tr v-for="user in users">
        <td>{{ user.name }}</td>
        <td>{{ user.phoneNumber }}</td>
        <td>{{ user.address }}</td>
        <td>{{ user.postalCode }}</td>
        <td>{{ user.local }}</td>
        <td>{{ user.link }}</td>
        <td>{{ user.image }}</td>
        <td>{{ <a href="#">Edit</a> }}</td> <!-- lINK, ou outra coisa para uma função, que me encaminha com um pedido PUT e o id -->
        <td> <button id="btn" class="" v-on:click="deleteUser(user.id)">Delete</button> </td> <!-- Delete "http://localhost:3000/users/"+user.id // lINK, ou outra coisa para uma função, que me encaminha com um pedido DELETE e o id -->
      </tr>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  name: 'course-list-row',
  mounted() {
    this.getUsers()
    console.log('Component mounted.')
  },
  data() {
    return {
      name: '',
      phoneNumber: '',
      address: '',
      postalCode: '',
      local: '',
      link: '',
      counter: 0,
      image: '',
      
      errors: [],
      users: [],
    }
  },
  methods: {
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
        image: this.image,
      }, 
      {
        headers: {
          'Content-Type': 'multipart/form-data',
        }
      },)
      .then(function(response) { //response => {}
        //console.log(this.name);
        console.log('Response: '+response);

        const status = JSON.parse(response.status);
        if (status == '201') {
          self.$router.push('show');
        }
      })
      .catch(e => {
        this.errors.push(e)
      })   

    },

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
        self.users = response.data
      })
      .catch(function(error) {
        console.log(error)
      })
    },

    deleteUser(userId){
      //console.log(userId);
      let self = this
      axios.delete('http://localhost:3000/users/'+userId).then(function(response) { //response => {}
        //console.log(this.name);
        console.log(response);

      const status = JSON.parse(response.status);
        if (status == '204') {
          self.$router.push('insert');
        }
      });
    },
  }
}
</script>

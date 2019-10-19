<template>
  <div style="background:transparent !important" class="jumbotron">
    <fieldset class="border border-dark">
      <legend id="Legend5" runat="server" visible="true" style="width:auto; margin-bottom:0px; margin-left:40px; font-size:20px; font-weight:bold;">Inserir Nova Empresa</legend>
      <div class="mt-2 col-md-12">
        
        <b-form id="app" @submit="checkForm" action="http://localhost:3000/users" method="post">
          <p v-if="errors.length">
            <b>Please correct the following error(s):</b>
            <ul>
              <li v-for="error in errors">{{ error }}</li>
            </ul>
          </p>

          <div class="row">
            <div class="col">
              <b-form-group id="input-group-2" label="Your Name:" label-for="input-2">
                <b-form-input
                  id="name"
                  v-model="name"
                  required
                  name= "name"
                  placeholder="Enter name"
                ></b-form-input>
              </b-form-group>
            </div>
            <div class="col">
              <b-form-group id="input-group-2" label="Your Phone Number:" label-for="input-2">
                <b-form-input
                  id="phoneNumber"
                  v-model="phoneNumber"
                  required
                  name= "phoneNumber"
                  type= "number"
                  placeholder="Enter phone number"
                ></b-form-input>
              </b-form-group>
            </div>
          </div>
          
          <b-form-group id="input-group-2" label="Your Address:" label-for="input-2">
            <b-form-input
              id="address"
              v-model="address"
              required
              name= "address"
              placeholder="Enter address"
            ></b-form-input>
          </b-form-group>

          <div class="row">
            <div class="col">
              <b-form-group id="input-group-2" label="Your Local:" label-for="input-2">
                <b-form-input
                  id="local"
                  v-model="local"
                  required
                  name= "local"
                  placeholder="Enter local"
                ></b-form-input>
              </b-form-group>
            </div>
          
            <div class="col">
              <b-form-group id="input-group-2" label="Your Postal Code:" label-for="input-2">
                <b-form-input
                  id="postalCode"
                  v-model="postalCode"
                  required
                  name= "postalCode"
                  placeholder="Enter postal code"
                ></b-form-input>
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
</template>

<script>
import axios from 'axios';

export default {
  data() {
    return {
      name: '',
      phoneNumber: '',
      address: '',
      postalCode: '',
      local: '',
      errors: [],
    }
  },

  // Pushes posts to the server when called.
postPost() {
  axios.post('http://localhost:3000/users',
   {headers: {'Content-Type': 'application/json'}},
   {body: {"name":this.name,"phoneNumber":this.phoneNumber,"address":this.address,"postalCode":this.postalCode,"local":this.local}})
  .then(response => {})
  .catch(e => {
    this.errors.push(e)
  })
}

  /*postPost() {
    axios.post('http://localhost:3000/users', {
      body:{"name":""+this.name,"phoneNumber":""+this.phoneNumber,"address":""+this.address,"postalCode":""+this.postalCode,"local":""+this.local}
    })
    .then(response => {})
    .catch(e => {
      this.errors.push(e)
    })
  }*/
}
</script>

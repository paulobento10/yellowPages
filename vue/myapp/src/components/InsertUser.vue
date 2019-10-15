<template>
<form id="app" @submit="checkForm" action="http://localhost:3000/users" method="post" >

  <p v-if="errors.length">
    <b>Please correct the following error(s):</b>
    <ul>
      <li v-for="error in errors">{{ error }}</li>
    </ul>
  </p>

  <p>
    <label for="name">Name</label>
    <input id="name" v-model="name" type="text" name="name">
  </p>

  <p>
    <label for="phoneNumber">Phone Number</label>
    <input id="phoneNumber" v-model="phoneNumber" type="text" name="phoneNumber">
  </p>

  <p>
    <label for="address">Address</label>
    <input id="address" v-model="address" type="text" name="address">
  </p>

  <p>
    <label for="postalCode">Postal Code</label>
    <input id="postalCode" v-model="postalCode" type="text" name="postalCode">
  </p>

  <p>
    <label for="local">Local</label>
    <input id="local" v-model="local" type="text" name="local">
  </p>

  <p><input type="submit" value="Submit" @change="postPost()"></p>

</form>
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

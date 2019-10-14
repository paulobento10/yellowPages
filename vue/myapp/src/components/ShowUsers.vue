<template>
 <div id="users">
  <div v-for="(user, index) in users" :key="user.id">
   <p>{{user.name}} is my {{user.local}}</p>
  </div>
 </div>
</template>
<script>

const axios = require('axios');
var user;
async function getUsers(){
  const response = await axios.get('http://localhost:3000/users');
  user = response.data;
  console.log(user)
}

getUsers();

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

export default {

}
</script>

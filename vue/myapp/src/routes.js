/*const routes = [];

export default routes;*/
import Home from './components/Home.vue';
import Register from './components/Register.vue';
import Login from './components/Login.vue';
import ShowUsers from './components/ShowUsers.vue'

const routes = [
    { path: '/', component: Home },
    { path: '/register', component: Register },
    { path: '/login', component: Login },
    { path: '/show', component: ShowUsers },
];

export default routes;

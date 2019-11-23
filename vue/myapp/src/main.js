import Vue from 'vue';
import App from './App.vue';
import VueRouter from 'vue-router';
import routes from './routes';
import 'bootstrap/dist/css/bootstrap.css';
import 'bootstrap-vue/dist/bootstrap-vue.css';
import BootstrapVue from 'bootstrap-vue/dist/bootstrap-vue.esm';
import YmapPlugin from 'vue-yandex-maps'

const router = new VueRouter({routes});
const settings = {
  lang: 'uk_UA',
  coordorder: 'latlong',
};

Vue.config.productionTip = false;
Vue.use(YmapPlugin, settings)
Vue.use(VueRouter);
Vue.use(BootstrapVue);

new Vue({
  el: '#app',
  router,
  render: h => h(App)
}).$mount('#app');

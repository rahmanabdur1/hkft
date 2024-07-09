import './bootstrap';
import {createApp} from 'vue';
import app from './layouts/app.vue';
import router from './routes.js';
import VueChartkick from 'vue-chartkick'
import 'chartkick/chart.js'
const App= createApp(app);

import User from './helpers/User.js';
window.User = User;

import Swal from 'sweetalert2'

// CommonJS
window.Swal = Swal;



App.use(router).use(VueChartkick);
App.mount('#app');


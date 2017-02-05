// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_self

window.Vue = require('vue/dist/vue.common');
window.VueRouter = require('vue-router');

window.axios = require('axios');
axios.defaults.headers.common['X-CSRF-Token'] = $('meta[name="csrf-token"]').attr('content');

window.bus = new Vue();

Vue.use(VueRouter);

var GameIndex = require('./components/game_index');
var GameShow = require('./components/game_show');
var GameNew = require('./components/game_new');

router = new VueRouter({
  routes: [
    { path: '/', name: 'games', component: GameIndex },
    { path: '/games/new', name: 'new_game', component: GameNew },
    { path: '/games/:gameId', name: 'game', component: GameShow }
  ]
});

new Vue({
  el: '#app',

  router,

  created: function() {

    bus.$on('show-game', function(id) {
      router.push({name: 'game', params: { gameId: id}});
    });

    bus.$on('new-game', function(id) {
      router.push({name: 'new_game'});
    });

  }
});

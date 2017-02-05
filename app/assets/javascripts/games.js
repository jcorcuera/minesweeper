new Vue({
  el: '#app',

  data: {
    games: []
  },

  created: function() {
    this.fetchGames();
  },

  methods: {
    fetchGames: function() {
      var that = this;
      axios.get('/api/games.json')
        .then(function(response) {
          that.games = response.data;
        });
    }
  }
})

<template>

  <div>
    <h2>Current Games:</h2>

    <ul>
      <li v-for="game in games">
        ID: {{game.id}} - Dimensions: {{game.rows}} x {{game.cols}} - Mines: {{ game.mines }}
        (<a @click="showGame(game)">Play</a>)
      </li>
    </ul>
  </div>

</template>

<script>

module.exports = {

  data: function() {
    return {
      games: []
    };
  },

  created: function() {
    console.log('created!');
    this.fetchGames();
  },

  methods: {
    fetchGames: function() {
      var that = this;
      axios.get('/api/games.json')
        .then(function(response) {
          that.games = response.data;
        });
    },

    showGame: function(game) {
      bus.$emit('show-game', game.id);
    }
  }
}

</script>

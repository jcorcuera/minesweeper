<template>

  <div>

    <h2 v-if="game">
      Dimensions: {{game.rows}} x {{game.cols}} - Mines: {{ game.mines }}
    </h2>

    <table v-if="game" class='board'>
      <tbody>
        <template v-for="(row, rindex) in game.board">
          <tr>
            <td v-for="(value, cindex) in row">

              <button v-if="value == '%'" @click="reveal(rindex, cindex)" class='tile closed'></button>
              <div v-else-if="value == '*'" class='tile bomb'>*</div>
              <div v-else-if="value == 'X'" class='tile exploted-bomb'>X</div>
              <div v-else class='tile number'>{{value}}</div>

            </td>
          </tr>
        </template>
      </tbody>
    </table>
  </div>

</template>

<script>

module.exports = {

  data: function() {
    return {
      game: null
    }
  },

  created: function() {
    this.fetchGame(this.$route.params.gameId);
  },

  methods: {

    fetchGame: function(gameId) {
      var that = this;
      axios.get('/api/games/' + gameId + '.json')
        .then(function(response){
          that.game = response.data;
        });
    },

    reveal: function(row, col) {
      var that = this;
      axios.post('/api/games/' + this.game.id + '/reveal.json', {
          row: row,
          col: col
        })
        .then(function(response){
          that.game = response.data;
        });
    }

  }
}

</script>

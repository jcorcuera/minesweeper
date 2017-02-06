<template>

  <div>

    <h2> New Game </h2>

    <form v-on:submit.prevent="onSubmit">
      <div>
        <label>Numher of Rows:</label>
        <input v-model.number="game.rows" type="number" name="rows" min="1" max="30" required>
      </div>
      <div>
        <label>Numher of Cols:</label>
        <input v-model.number="game.cols" type="number" name="rows" min="1" max="30" required>
      </div>
      <div>
        <label>Numher of Mines:</label>
        <input v-model.number="game.mines" type="number" name="mines" min="1" required>
      </div>

      <button type="submit" value="Submit">Submit</button>
    </form>

  </div>

</template>

<script>

module.exports = {

  data: function() {
    return {
      game: {
        rows: 0,
        cols: 0,
        mines: 0
      }
    }
  },

  methods: {

    onSubmit: function() {
      axios.post('/api/games.json', {
          game: this.game
        }).then(function(response) {
          bus.$emit('show-game', response.data.id);
        });
    }

  }
}

</script>

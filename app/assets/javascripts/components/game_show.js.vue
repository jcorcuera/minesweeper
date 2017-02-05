<template>
  <div>
    Show
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
    }

  }
}

</script>

# Minesweeper

## Stack:

* Database: Postgresql
* Rails: 5
* Ruby: 2.2
* VueJS 2.1

## Issues:

https://github.com/jcorcuera/minesweeper/issues

## Notes:

### Game Model:

* The game board is stored in an field `state`, which is a text column in
  the db. [Game Model](../blob/master/app/models/game.rb#L65)
* Every tile is represented by a symbol. [Game::TILE](../blob/master/app/models/game.rb#L5-L11)
* The `board` method returns the board as an array of array, where every
  represents a tile. [Game#board](../blob/master/app/models/game.rb#L18-L24)
* Game model provides methods for accessing and changing its internal
  state.
* [Game model's Specs](../blob/master/spec/models/game_spec.rb)

### Services:

* Encapsulate all functionality related to an action.

#### GameCreationService:

* Creates a game with the provided parameters.
* Generates a random board bse on the custom values.
* [Specs](../blob/master/spec/services/game_create_service_spec.rb)

#### GameTileRevealService:

* Perform the action of reveal a tile.
* Use a recursive function to continue revealing tiles as long as there
  are no bombs near.
* Handles bomb explosion.
* [Specs](../blob/master/spec/services/game_tile_reveal_service_spec.rb)

### Game Controller:

* Expose json endpoint for performing actions on a game.
* Use ActivemodelSerializer to return json response. [Game Serializer](../blob/master/app/serializers/game_serializer.rb)
* Use services to encapsulate functionality.

### Views:

* Use a VueJS application to handle all client side. [Vue Main App](../blob/master/app/assets/javascripts/application.js)
* Use vue-router to map paths to compenents.[Vue Router](../blob/master/app/assets/javascripts/application.js#L31-L37)
* Use components to separate actions inside their own scope.[Components](../tree/master/app/assets/javascripts/components)
* Use event messaging to handle communication between parts of the
  application.[Bus](../blob/master/app/assets/javascripts/application.js#L23)
* Use axios to retrieve resources via ajax.

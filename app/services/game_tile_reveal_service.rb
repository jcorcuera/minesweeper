class GameTileRevealService

  attr_reader :game, :row, :col

  def initialize(game:, row:, col:)
    @game = game
    @row = row
    @col = col
  end

  def perform
    reveal(row, col)
  end

  def reveal(_row, _col, queue=[])
    current_tile = game.tile_at(_row, _col)

    raise Game::BombExploded if current_tile == GAME::TILE[:bomb]

    if current_tile == Game::TILE[:closed]
      near_tiles = game.near_tiles_at(_row, _col)
      total_bombs =  near_tiles.count {|r,c| game.tile_at(r,c) == GAME::TILE[:bomb] }
      game.tile_set(_row, _col, total_bombs.to_s)
      queue += near_tiles if total_bombs.zero?
    end

    reveal(queue.shift, queue)
  end

end

class GameTileRevealService

  attr_reader :game, :row, :col

  def initialize(game:, row:, col:)
    @game = game
    @row = row
    @col = col
  end

  def perform
    reveal(row, col)
    game.save!
  end

  def reveal(_row, _col, queue=[])
    current_tile = game.tile_at(_row, _col)

    raise Game::BombExploded if current_tile == Game::TILE[:bomb]

    if current_tile == Game::TILE[:closed]
      near_tiles = game.near_tiles_at(_row, _col)
      total_bombs =  near_tiles.count {|r,c| game.tile_at(r,c) == Game::TILE[:bomb] }
      game.tile_set(_row, _col, total_bombs.to_s)
      queue += near_tiles if total_bombs.zero?
    end

    return if queue.blank?

    reveal(*queue.shift, queue)
  end

  def handle_explosion
    game.finished_at = Time.now
    game.won = false
    game.tile_set(row, col, Game::TILE[:exploded_bomb])
    game.save
  end

end

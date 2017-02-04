class GameTileRevealService

  attr_reader :game, :row, :col

  def initialize(game:, row:, col:)
    @game = game
    @row = row
    @col = col
  end

  def perform
    raise "BOMB" if game.tile_at(row, col)
  end

end

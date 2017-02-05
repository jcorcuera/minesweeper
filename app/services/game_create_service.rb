class GameCreateService

  attr_reader :game

  def initialize(rows:, cols:, mines:)
    @game = Game.new(rows: rows, cols: cols, mines: mines)
  end

  def perform
    raise_unless_valid?
    game.state = generate_board
    game.save!
  end

  def raise_unless_valid?
    game.validate!
  end

  private

  def generate_board
    board = Array.new(game.total_tiles - game.mines, Game::TILE[:closed])
    board += Array.new(game.mines, Game::TILE[:bomb])
    board.shuffle.join
  end

end

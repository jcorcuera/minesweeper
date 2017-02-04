class GameCreateService

  attr_reader :game

  def initialize(rows:, cols:, mines:)
    @game = Game.new(rows: rows, cols: cols, mines: mines)
  end

  def perform
    game.state = generate_board
    game.save!
  end

  private

  def generate_board
    board = Array.new(game.total_tiles - game.mines, Game::TILE[:closed])
    board += Array.new(game.mines, Game::TILE[:bomb])
    board.shuffle.join
  end

end

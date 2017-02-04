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
    Array.new(game.rows * game.cols, '%').join
  end

end

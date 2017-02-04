class Game < ApplicationRecord
  class InvalidPosition < StandardError; end

  TILE = {
    closed: '%',
    bomb: '*',
    exploded_bomb: 'X'
  }


  validates :rows, presence: true
  validates :cols, presence: true
  validates :mines, presence: true

  def board
    load_board
  end

  def total_tiles
    rows * cols
  end

  def tile_at(row, col)
    raise InvalidPosition if !valid_row?(row) || !valid_col?(col)

    state[(row * cols) + col]
  end

  private

  def load_board
    state.split(//).in_groups_of(cols)
  end

  def valid_row?(row)
    row >= 0 && row < rows
  end

  def valid_col?(col)
    col >= 0 && col < cols
  end

end

# == Schema Information
#
# Table name: games
#
#  id         :integer          not null, primary key
#  rows       :integer
#  cols       :integer
#  mines      :integer
#  state      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

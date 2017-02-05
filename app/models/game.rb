class Game < ApplicationRecord
  class InvalidPosition < StandardError; end
  class BombExploded < StandardError; end

  TILE = {
    closed: '%',
    bomb: '*',
    exploded_bomb: 'X',
    flag: 'F',
    question_mark: '?'
  }


  validates :rows, presence: true, numericality: { only_integer: true }
  validates :cols, presence: true, numericality: { only_integer: true }
  validates :mines, presence: true, numericality: { only_integer: true }

  def board
    _board = state
    _board = state.gsub(TILE[:bomb], TILE[:closed]) if finished_at
    _board
      .split(//)
      .in_groups_of(cols)
  end

  def total_tiles
    rows * cols
  end

  def tile_at(row, col)
    raise InvalidPosition if !valid_row?(row) || !valid_col?(col)

    state[(row * cols) + col]
  end

  def near_tiles_at(row, col)
    list_rows = [row - 1, row, row + 1].select {|r| valid_row?(r) }
    list_cols = [col - 1, col, col + 1].select {|c| valid_row?(c) }

    list_rows.product(list_cols) - [[row, col]]
  end

  def tile_set(row, col, value)
    state[(row * cols) + col] = value
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
#  id          :integer          not null, primary key
#  rows        :integer
#  cols        :integer
#  mines       :integer
#  state       :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  finished_at :datetime
#  won         :boolean          default("false")
#

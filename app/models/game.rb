class Game < ApplicationRecord

  TILE = {
    closed: '%',
    bomb: '*',
    exploded_bomb: 'X'
  }


  validates :rows, presence: true
  validates :cols, presence: true
  validates :mines, presence: true

  def board
    @board ||= load_board
  end

  private

  def load_board
    state.split(//).in_groups_of(cols)
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

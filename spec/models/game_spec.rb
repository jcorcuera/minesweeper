require 'rails_helper'

RSpec.describe Game, type: :model do

  let(:game) { create(:game) }
  let(:rows) { game.rows }
  let(:cols) { game.cols }

  describe "#board" do

    it { expect(game.board.class).to eq(Array) }
    it { expect(game.board.count).to eq(game.rows) }
    it { expect(game.board[0].count).to eq(game.cols) }

    context "tile position" do

      it "matches from state" do
        row, col = 3, 4
        position = (3 * cols) + col
        game.state[position] = Game::TILE[:bomb]
        game.save

        expect(game.board[3][4]).to eq(Game::TILE[:bomb])
      end

    end

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

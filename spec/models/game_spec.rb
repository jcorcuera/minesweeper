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
        game.state[position] = Game::TILE[:flag]
        game.save

        expect(game.board[3][4]).to eq(Game::TILE[:flag])
      end
    end
  end

  describe "#tile_at" do
    let(:valid_row) { rand(game.rows) }
    let(:valid_col) { rand(game.cols) }

    it 'return the tile at given position' do
      tile = game.tile_at(valid_row, valid_col)
      expect(tile).to eq(Game::TILE[:closed])
    end

    it 'raise an error for invalid access' do
      expect{ game.tile_at(-1,valid_col) }.to raise_error(Game::InvalidPosition)
    end
  end

  describe "#near_tiles_at" do

    it 'should not include current tile' do
      expect(game.near_tiles_at(1,1)).not_to include([1,1])
    end

    it 'should list tiles around' do
      near = [[0,0], [0,1], [0,2],
              [1,0],        [1,2],
              [2,0], [2,1], [2,2]]

      expect(game.near_tiles_at(1,1)).to eq(near)
    end

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

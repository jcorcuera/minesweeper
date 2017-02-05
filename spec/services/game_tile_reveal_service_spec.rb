require 'rails_helper'

RSpec.describe GameTileRevealService do

  let(:game) { create(:game, rows: 5, cols: 5) }
  let(:service) { described_class.new(game: game, row: row, col: col) }
  let(:row) { }
  let(:col) { }

  describe "#reveal" do

    before do
      game.state = %Q{
        % % % % %
        % % * % %
        % % % % %
        % % * * %
        % % % % %
      }.gsub(/\s+/, '')
      game.save
    end

    it 'raises an error if a bomb is revealed' do
      expect { service.reveal(1,2) }.to raise_error(Game::BombExploded)
    end

    it 'doesnt reveal near tiles if tile is not empty' do
      service.reveal(2,2)
      near_tiles = game.near_tiles_at(2,2).map {|tile| game.tile_at(*tile)}
      # the 5 tiles around remain closed, the other ones are bombs
      expect(near_tiles.count(Game::TILE[:closed])).to eq(5)
    end

    it 'set the corrent number of bombs around' do
      service.reveal(2,2)
      expect(game.tile_at(2,2)).to eq("3")
    end

    it 'reveals adjacend tiles if not bombs are around' do
      service.reveal(0,0)

      expected_state = %Q{
        0 1 % % %
        0 1 * % %
        0 2 % % %
        0 1 * * %
        0 1 % % %
      }.gsub(/\s+/, '')

      expect(game.state).to eq(expected_state)
    end

  end

end

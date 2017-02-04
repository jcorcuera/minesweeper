require 'rails_helper'

RSpec.describe GameCreateService do

  let(:service) { described_class.new(rows: rows, cols: cols, mines: mines) }
  let(:rows) { 5 }
  let(:cols) { 6 }
  let(:mines) { 4 }
  let(:game) { service.game }

  context "Game creation" do

    it "creates a game" do
      expect {
        service.perform
      }.to change{Game.count}.by(1)
    end

    it 'sets the proper attributes' do
      service.perform

      expect(game.rows).to eq(rows)
      expect(game.cols).to eq(cols)
      expect(game.mines).to eq(mines)
    end
  end

  context "Game setup" do

    before do
      service.perform
    end

    it 'generates a state with the correct number of tiles' do
      expect(game.state.length).to eq(game.total_tiles)
    end

    it 'generate a state with the proper number of mines' do
      expect(game.state.count(Game::TILE[:bomb])).to eq(game.mines)
    end

    it 'generate random states' do
      service2 = described_class.new(rows: rows, cols: cols, mines: mines)
      service2.perform
      game2 = service2.game

      expect(game.state).to_not eq(game2.state)
    end

  end


end

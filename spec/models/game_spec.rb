require 'rails_helper'

RSpec.describe Game, type: :model do

  let(:game) { create(:game) }


  describe "#board" do

    it { expect(game.board.class).to eq(Array) }
    it { expect(game.board.count).to eq(game.rows) }
    it { expect(game.board[0].count).to eq(game.cols) }

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

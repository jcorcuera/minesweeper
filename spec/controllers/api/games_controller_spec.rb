require 'rails_helper'

RSpec.describe API::GamesController, type: :controller do

  describe "GET #show" do
    let(:game) { create(:game) }

    it 'returns data of requested game' do
      get :show, params: { id: game.id, format: :json }
      json_response = JSON.parse(response.body)
      expect(response).to be_success
      expect(json_response['id']).to eq(game.id)
    end

    it 'returns an error if not found' do
      get :show, params: { id: -1, format: :json }
      json_response = JSON.parse(response.body)
      expect(response).to be_not_found
      expect(json_response['error']).to be_present
    end

  end

end

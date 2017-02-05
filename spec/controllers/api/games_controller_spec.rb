require 'rails_helper'

RSpec.describe Api::GamesController, type: :controller do

  describe "GET #index" do

    before do
      create_list(:game, 5)
      get :index, params: { format: :json }
    end

    it 'returns data of requested game' do
      expect(response).to be_success

      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq(5)
    end

  end

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

  describe "POST #create" do
    it 'returns data of requested game' do
      post :create, params: { game: { rows: 5, cols: 6, mines: 4 }, format: :json }

      json_response = JSON.parse(response.body)
      expect(response).to be_created
      expect(json_response['id']).to_not be_nil
    end

    it 'returns an error if required parameters are missing' do
      post :create, params: { game: { rows: 1 }, format: :json }

      json_response = JSON.parse(response.body)
      expect(response).to be_bad_request
      expect(json_response['error']).to be_present
    end
  end

  describe "POST #reveal" do
    let(:game) { create(:game) }

    it 'returns data of requested game' do
      post :reveal, params: { id: game.id, row: 1, col: 1, format: :json }

      json_response = JSON.parse(response.body)
      expect(response).to be_success
      expect(json_response['id']).to eq(game.id)
    end

    it 'returns an error if position is invalid' do
      post :reveal, params: { id: game.id, row: -1, col: -1, format: :json }

      json_response = JSON.parse(response.body)
      expect(response).to be_bad_request
      expect(json_response['error']).to be_present
    end
  end

end

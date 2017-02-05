class GamesController < ApplicationController

  before_action :find_game, only: [:show]

  def show
    render json: @game
  end

  protected

  def find_game
    @game = Game.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Game does not exist' }, status: :not_found
  end

end

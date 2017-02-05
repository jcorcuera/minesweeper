class API::GamesController < API::BaseController

  before_action :find_game, only: [:show]

  def show
    render json: @game
  end

  protected

  def find_game
    @game = Game.find(params[:id])
  end

end

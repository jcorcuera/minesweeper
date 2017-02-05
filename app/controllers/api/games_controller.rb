class API::GamesController < API::BaseController

  before_action :find_game, only: [:show]

  def index
    # TODO: Add pagination
    @games = Game.all
    render json: @games
  end

  def show
    render json: @game
  end

  protected

  def find_game
    @game = Game.find(params[:id])
  end

end

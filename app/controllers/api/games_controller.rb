class API::GamesController < API::BaseController

  before_action :find_game, only: [:show, :reveal]

  def index
    # TODO: Add pagination
    @games = Game.all
    render json: @games
  end

  def show
    render json: @game
  end

  def reveal
    service = GameTileRevealService.new(
      game: @game,
      row: params[:row].to_i,
      col: params[:col].to_i
    )
    service.perform
    render json: service.game
  rescue Game::InvalidPosition
    render json: { error: 'Invalid Position' }, status: :bad_request
  end

  protected

  def find_game
    @game = Game.find(params[:id])
  end

end

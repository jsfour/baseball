class V1::GamesController < ApplicationController

  def index
    games = Game.all
    render json: games, status: :ok
  end

  def create
    game = Game.new(game_params)
    if game.save
      render json: game, status: :created
    else
      render json: nil, status: :error
    end
  end

  def destroy
    game = Game.find(params[:id])
    if game.destroy
      render json: nil, status: :ok
    else
      render json: nil, status: :error
    end
  end

private
  def game_params
    params.permit(:home_team_id, :away_team_id)
  end

end

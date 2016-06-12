class V1::GamesController < ApplicationController

  def create
    game = Game.new(game_params)
    if game.save
      render body: game_serailize(game).to_json, status: :created
    else
      render body: nil, status: :error
    end
  end

private
  def game_params
    params.permit(:home_team_id, :away_team_id)
  end

  def game_serailize game
    {
      game_id: 1,
      home_team_id: game.home_team.id,
      away_team_id: game.away_team.id
    }
  end

end

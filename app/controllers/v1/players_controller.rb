class V1::PlayersController < ApplicationController

  def index
    players = Player.all
    render json: players, status: :ok
  end

  def destroy
    player = Player.find(params[:id])
    if player.destroy
      render json: nil, status: :ok
    else
    render json: nil, status: :error
    end
  end

  def update
    player = Player.find(params[:id])
    if player.update_attributes(player_update_params)
      render json: player, status: :created
    else
      render json: player, status: :error
    end
  end

  def show
    player = Player.find_by_id(params[:id])
    if player.nil?
      render json: nil, status: :not_found
    else
      render json: player, status: :found
    end
  end


  def create
    player = Player.new(player_params)
    if player.save
      render json: player, status: :created
    else
      render json: nil, status: :error
    end
  end

private
  def player_params
    params.permit(:first_name, :last_name, :number, :team_id)
  end

  # Seperate to remove the abiity to change the team
  def player_update_params
    params.permit(:first_name, :last_name)
  end
end

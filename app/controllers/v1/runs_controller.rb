class V1::RunsController < ApplicationController

  def create
    run = Run.new(run_params)
    if run.save
      render json: run, status: :created
    else
      render json: nil, status: :error
    end
  end

private
  def run_params
    params.permit(:game_id, :player_id, :batter_id)
  end
end

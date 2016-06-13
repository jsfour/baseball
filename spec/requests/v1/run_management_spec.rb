require 'rails_helper'
RSpec.describe "Run management", type: :request do
  describe "#create" do
    let(:game){ FactoryGirl.create(:game) }
    let(:player_on_other_team){ FactoryGirl.create(:player) }
    let(:player){ FactoryGirl.create(:player, team: game.home_team) }
    let(:batter){ FactoryGirl.create(:player, team: game.home_team) }
    let(:run_params){ { game_id: game.id, player_id: player.id, batter_id: batter.id } }
    subject do
      post "/v1/runs", run_params.to_json, headers
      response
    end
    describe "correctly formatted" do
      context "successfully" do
        it_behaves_like "a created json response"
        it "shouldnt allow you to create runs for people on diffrent teams"
      end
    end
    describe "incorrectly formatted" do
      context "fails for players on seperate teams" do
        let(:run_params){ { game_id: game.id, player_id: player.id, batter_id: player_on_other_team.id } }
        it_behaves_like "failed json response"
      end
      context "fails for players not playing the game"
    end
  end

end

require 'rails_helper'

RSpec.shared_examples "a json response" do
  it { expect(subject.content_type).to eq("application/json") }
end

RSpec.describe V1::GamesController, type: :request do
  let(:headers) do
    {
      "ACCEPT" => "application/json",
      "CONTENT_TYPE" => "application/json"
    }
  end

  describe "#create" do
    let(:home_team){ FactoryGirl.create(:team) }
    let(:away_team){ FactoryGirl.create(:team) }
    let(:game_params){ { home_team_id: home_team.id, away_team_id: away_team.id } }
    subject do
      post "/v1/games", game_params.to_json, headers
      response
    end
    describe "correctly formatted" do
      context "successfully" do
        it_behaves_like "a json response"
        it { expect(subject).to have_http_status(:created) }
        it { expect(JSON.parse(subject.body)["home_team"]["id"]).to eql(home_team.id) }
        it { expect(JSON.parse(subject.body)["away_team"]["id"]).to eql(away_team.id) }
        it "should display the score"
        it { expect(subject.code).to eql("201") }
        it { expect{subject}.to change{Game.count}.by(1) }
        it "has correct game ids" do
          subject
          last_game = Game.last
          expect(last_game.home_team.id).to eql home_team.id
          expect(last_game.away_team.id).to eql away_team.id
        end

      end
    end
    describe "incorectly formatted" do
      context "no home_team_id" do
        let(:game_params){ { away_team_id: away_team.id } }
        it { expect(subject.code).to eql("500") }
      end
      context "no away_team_id" do
        let(:game_params){ { home_team_id: home_team.id } }
        it { expect(subject.code).to eql("500") }
      end
    end

  end

  describe "#destroy" do
    let!(:game){ FactoryGirl.create(:game) }
    subject { delete "/v1/games/#{game.id}", headers }
    context "successfully" do
      it { expect{subject}.to change{Game.count}.from(1).to(0) }
      it { expect{subject}.to change{Game.find_by_id(game.id)}.from(game).to(nil) }
      it "should delete all scores associated"
    end
  end

  describe "#index" do
    context "successfully" do
      let!(:game_list) { FactoryGirl.create_list(:game, 5) }
      subject do
        get "/v1/games", headers
        response
      end
      it { expect(subject).to have_http_status(:ok) }
      it { expect(JSON.parse(subject.body).map{|game| game["id"]}).to eq game_list.map{|game| game.id} }
    end
  end

  describe "#show" do
    context "successfully" do
      it "should should display the score"
    end
  end

  describe "#update" do
    pending "TODO: Add update features with more time"
  end

end

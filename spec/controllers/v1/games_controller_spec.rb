require 'rails_helper'

RSpec.describe V1::GamesController, type: :controller do

  describe "#create" do
    let(:home_team){ FactoryGirl.create(:team) }
    let(:away_team){ FactoryGirl.create(:team) }
    subject do
      post :create, home_team_id: home_team.id, away_team_id: away_team.id
    end
    describe "correctly formatted" do
      context "successfully" do
        let(:expected_response) do
          {
            game_id: 1,
            home_team_id: home_team.id,
            away_team_id: away_team.id
          }
        end
        it { expect(subject.body).to eql(expected_response.to_json) }
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
        subject { post :create, away_team_id: away_team.id }
        it { expect(subject.code).to eql("500") }
      end
      context "no away_team_id" do
        subject { post :create, home_team_id: home_team.id }
        it { expect(subject.code).to eql("500") }
      end
    end

  end

  describe "#show" do
    context "successfully" do
      it "should should display the score"
    end
  end

  describe "#delete" do
    context "successfully" do
      it "should delete the game"
      it "should delete all scores associated"
    end
  end

  describe "#update" do
    pending "TODO: Add update features with more time"
    # not much to update on the game level so there is no update functionality.
  end

end

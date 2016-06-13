require 'rails_helper'
RSpec.describe "Player management", type: :request do
  let(:team){ FactoryGirl.create(:team) }
  describe "#create" do
    let(:player_params){ { first_name: "Clark", last_name: "Kent", number: 55, team_id: team.id } }
    subject do
      post "/v1/players", player_params.to_json, headers
      response
    end
    describe "correctly formatted" do
      context "successfully" do
        it_behaves_like "a json response"
        it { expect(JSON.parse(subject.body)["first_name"]).to eql("Clark") }
        it { expect(JSON.parse(subject.body)["last_name"]).to eql("Kent") }
        it { expect(JSON.parse(subject.body)["number"]).to eql(55) }
        it { expect(JSON.parse(subject.body)["team_id"]).to eql(team.id) }
        it { expect(subject).to have_http_status(:created) }
        it { expect{subject}.to change{Player.count}.from(0).to(1) }
        it { expect{subject}.to change{team.players.count}.from(0).to(1) }
      end
    end

    describe "incorrect params" do
      context "fails becsuse of missing number" do
        let(:player_params){ { first_name: "Clark", last_name: "Kent", team_id: team.id } }
        it_behaves_like "failed json response"
        it { expect{subject}.to_not change{Player.count} }
        it { expect{subject}.to_not change{team.players.count} }
      end
      context "fails becsuse of missing team" do
        let(:player_params){ { first_name: "Clark", last_name: "Kent", number: 55 } }
        it_behaves_like "failed json response"
        it { expect{subject}.to_not change{Player.count} }
        it { expect{subject}.to_not change{team.players.count} }
      end
      context "fails becsuse of duplicate number on same team" do
        let!(:existing_player){ FactoryGirl.create(:player, team: team, number: 55) }
        let(:player_params){ { first_name: "Clark", last_name: "Kent", number: 55, team_id: team.id } }
        it_behaves_like "failed json response"
        it { expect{subject}.to_not change{Player.count} }
        it { expect{subject}.to_not change{team.players.count} }
      end
    end
  end
  describe "#show" do
    let!(:player){ FactoryGirl.create(:player, first_name: "Super", last_name: "Man", team: team) }
    subject do
      get "/v1/players/#{player.id}", headers
      response
    end
    context "player that exists" do
      it_behaves_like "a json response"
      it { expect(subject).to have_http_status(:found) }
      it { expect(JSON.parse(subject.body)["first_name"]).to eql(player.first_name) }
      it { expect(JSON.parse(subject.body)["last_name"]).to eql(player.last_name) }
      it { expect(JSON.parse(subject.body)["number"]).to eql(player.number) }
      it { expect(JSON.parse(subject.body)["team_id"]).to eql(player.team_id) }
    end
    context "player that doesnt exist" do
      let(:player){ double("player", id: 999) }
      it_behaves_like "a json response"
      it { expect(subject).to have_http_status(:not_found) }
      it { expect(subject.body).to eq "null" }
    end
  end
  describe "#index" do
    let!(:players){ FactoryGirl.create_list(:player, 5) }
    subject do
      get "/v1/players", headers
      response
    end
    it_behaves_like "a json response"
    it { expect(subject).to have_http_status(:ok) }
    it { expect(JSON.parse(subject.body).map{|player| player["id"]}).to eq players.map{|player| player.id} }
  end

  describe "#update" do
    let!(:player){ FactoryGirl.create(:player, first_name: "Super", last_name: "Man", team: team) }
    subject do
      put "/v1/players/#{player.id}", new_params.to_json, headers
      response
    end
    context "failure number change" do
      let(:new_team){ FactoryGirl.create(:team) }
      let(:new_params){ { number: 99999} }
      it_behaves_like "a json response"
      it { expect(subject).to have_http_status(:created) }
      it { expect{subject}.to_not change{Player.find(player.id).number} }
    end
    context "failure team change" do
      let(:new_team){ FactoryGirl.create(:team) }
      let(:new_params){ { team_id: new_team.id} }
      it_behaves_like "a json response"
      it { expect(subject).to have_http_status(:created) }
      it { expect{subject}.to_not change{Player.find(player.id).team_id} }
    end
    context "successfully with everything but team and number" do
      let(:new_params){ { first_name: "New", last_name: "Name" } }
      it_behaves_like "a json response"
      it { expect(subject).to have_http_status(:created) }
      it { expect(JSON.parse(subject.body)["id"]).to eql(player.id) }
      it { expect(JSON.parse(subject.body)["first_name"]).to eql("New") }
      it { expect(JSON.parse(subject.body)["last_name"]).to eql("Name") }
      it { expect{subject}.to change{Player.find(player.id).first_name}.to("New") }
      it { expect{subject}.to change{Player.find(player.id).last_name}.to("Name") }
    end
  end

  describe "#delete" do
    let!(:player){ FactoryGirl.create(:player, first_name: "Super", last_name: "Man", team: team) }
    subject do
      delete "/v1/players/#{player.id}", headers
      response
    end
    context "successfully for deleted player" do
      it_behaves_like "a json response"
      it { expect(subject).to have_http_status(:ok) }
      it { expect{subject}.to change{Player.count}.by(-1) }
    end
  end
end

FactoryGirl.define do
  factory :game do
    home_team_id 1
    away_team_id 1

    before(:create) do |game|
      game.home_team = FactoryGirl.create(:team)
      game.away_team = FactoryGirl.create(:team)
    end
  end
end

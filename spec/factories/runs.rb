FactoryGirl.define do
  factory :run do
    game
    before(:create) do |run|
      game.player = FactoryGirl.create(:player, team: run.game.home_team)
      game.batter = FactoryGirl.create(:player, team: run.game.home_team)
    end
  end
end

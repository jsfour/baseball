class Run < ActiveRecord::Base
  belongs_to :player
  belongs_to :batter, class_name: "Player"
  belongs_to :game
  validates :player_id, :batter_id, :game_id, presence: true
  validate :player_and_batter_same_team

private
  def player_and_batter_same_team
    if player.team.id == batter.team.id
      return true
    else
      errors.add(:batter, "must be on the same team as the player")
      return false
    end
  end
end

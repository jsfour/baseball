class Game < ActiveRecord::Base
  belongs_to :home_team, class_name: "Team"
  belongs_to :away_team, class_name: "Team"
  has_many :runs, dependent: :destroy
  validates :home_team_id, :away_team_id, presence: true

end

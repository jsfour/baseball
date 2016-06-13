class Player < ActiveRecord::Base
  belongs_to :team
  validates :team_id, :number, presence: true
  validates :number, uniqueness: { scope: :team_id }

end

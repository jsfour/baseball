class GameSerializer < ActiveModel::Serializer
  type :game
  attribute :id
  belongs_to :home_team, key: :home_team, serializer: TeamSerializer
  belongs_to :away_team, key: :away_team, serializer: TeamSerializer

end

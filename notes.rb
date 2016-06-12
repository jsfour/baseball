class Game
  teams: [Team]
  players: through_teams
  innings: [Inning]
end

class Team
  name: String
  players: [Player]
  league: League
end

class Player
  first_name: String
  last_name: String
  number: Integer
  photos: [Media]
  videos: [Media]

end

class Inning
  team_at_bat: Team
  team_at_field: Team
  runs: [Run]
end

class Run
  player: Player =>KEY
  batter: Batter =>KEY
  inning: Inning
  before_filter "confirm player and batter on the same team"
end

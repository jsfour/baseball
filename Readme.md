# Development

This project was build on docker --specially for the docker-compose function. This allows for me to quickly adjust to different databases, rails/ruby versions, etc. It also allows for the development environment to remain consistent across multiple developers.

```
  rm config/database.yml
  cp config/database.template.mysql.yml config/database.yml
  docker-compose run development rake db:create
```

Do your development using:
```
docker-compose up development
```

Do your testing using (assuming that you are using rspec):
```
docker-compose run test
```

# Report

#### Where did you find difficulty in building a solution?
It took a little bit of time to get the app configured.

I'm not a big fan of using rails scaffolding for API's because since there isn't an interface I want to be EXTREMELY explicit with what the app is doing. I also think its very hard to write a stable API without integration tests. My thoughts are that there is no UI to click around in and crafting CURL/Postman requests gets old quick.

Getting the test suite configured probably took the most time since everything needed to be added manually.

#### Which parts were fun and inspirational to you?
I really like laying solid groundwork --especially for API's. So getting the test suite configured and writing the tests along side of the code

Actually I feel like I was getting to the really fun part at the end of the 5 hours. Building the query

I also like thinking about how to setup the application. I tried to build it so that it could be seperated into diffrent services somewhat easier. I figured there are going to be far more writes on the "Runs" table so at some point we could move posts onto a service hung on the api namespace and beef it up if we needed to.

#### If you had more time, what would you do next?
* Finish the levels
* Documentation. I was trying to write code so there is really no documentation.
* Authentication. Currently the app has no authentication scheme. I would build some type of a user model and allow users to take action.
* Improve game editing. Right now the teams in a game can not be changed after a game is created. This is to prevent dependency errors, IE the user creates a game allocates scores, then changes the team the scores will be lost. This would be a less of an issue with a UI. But with API's it easy to just post data into the service.

I chose to come back to this because I don't see too many instances where someone would create a game with the wrong teams in the first version of the application --plus when I was writing it the Runs model didn't exist yet. It would be easy to add later.
* Move all public identifiers to some type of a masked identification. ie /v1/players/sd2u32b as opposed to /v1/players/3
* Better error messages in the responses right now the api throws an error. It would be good to send back more information on the problem.
* Better indexing on the database
* Allow user to change a player to another team. Right now if you update a player's team it could in accidentally change the score for a game. To avoid this in the short term I just don't allow the team to be changed. Ideally, however, if the team was changed for a player it would lose on

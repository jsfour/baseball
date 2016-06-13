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

I'm not a big fan of using rails scaffolding for API's because since there isn't an GUI I want to be EXTREMELY explicit with what the app is doing. I also think its very hard to write a stable API without integration tests. My thoughts are that there is no UI to click around in and crafting CURL/Postman requests to test the API gets old quick.

Getting the app setup and test suite configured probably took a big chunk of time since everything needed to be added manually.

#### Which parts were fun and inspirational to you?
I really like laying solid groundwork --especially for API's! So getting the test suite configured and writing the tests along side of the code is very satisfying. It makes me feel like the system is stable and that I only need to write things one time.

I also find that good testing helps make sure the code is well organized and explicit. I feel like I was getting to the really fun part at the end of the 5 hours. Building the query's into the index views and adding caching would have a been a bit of fun.

I also like thinking about how to setup the application. I organized the api into a namespace "v1" so that in the future we could add additional versions of the API without needing to move anything. I also tried to think of Players, Games, etc as different services. I figured there are going to be far more writes on the "Runs" table so at some point we could move actions onto a service hung on the api namespace and beef it up if we needed to.

#### If you had more time, what would you do next?
* Finish the application
* Add in a feature to track the game state
* Documentation. I was trying to write code so there is not mucuh documentation.
* Authentication. Currently the app has no authentication scheme. In the short run, I would add in some kind of a environment var based authentication token check into the rack. In the long run, I would build some type of a user model and allow users to take action on things they own. An Oauth style auth would be a good idea here. Eg. We could build an engine and hang it off of /v1/signin that had a sign in prompt then when the user signed in, we would grant them a token and callback to the authentication server. The token would be save the token into the database and the client would then be responsible for holding on to that token so that and all future requests would need that token to access the API.
* Improve game editing. Right now the teams in a game can not be changed after a game is created. This is to prevent dependency errors, IE. the user creates a game allocates scores, then makes changes to the teams the scores would be messed up. This would be a less of an issue with a UI since you can build UI around it to keep this from happening. But with API's it easy to send in data accidentally (or on purpose). Recommendation would be to no allow updating teams on games but force the user to create a new game and archive the old one. I chose to come back to this because I don't see too many instances where someone would create a game with the wrong teams in the first version of the application --plus when I was writing it the Runs model didn't exist yet. It would be easy to add later.
* Move all public identifiers to some type of a masked identification. ie /v1/players/sd2u32b as opposed to /v1/players/3
* Better error messages in the responses right now the api throws an error. It would be good to send back more information on the problem if the API has one. V1 error messages probably would just be codes with some documentation, then V2 we could just send back an "error" json object that is more verbose.
* Better indexing on the database
* Allow user to change a player to another team while keeping the runs associated with the game the player played.

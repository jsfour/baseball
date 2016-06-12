# Rails Docker Install

This project is everything you need to bootstrap a brand new rails application inside docker. It's meant to help you develop faster using docker. I haven't tried it in production.

The rails app built is setup to work on mysql. I have also included redis if you are using sidekick.

```
  mkdir app-name
  cd app-name
  git clone https://github.com/jsmootiv/docker-rails .
  rm -rf .git/
  docker-compose build bootstrap
  docker-compose run bootstrap
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
docker-compose up test
```

## Things done with more time
- Documentation. Right now the API isnt documented well.
- Authentication. Currently the app has no authentication scheme. I would build some type of a user model and allow them to auth using tokens.
- Improve game editing. Right now the team can not be changed after a game is created. This is to prevent dependency errors, IE the user creates a game allocates scores, then changes the team the scores will be lost.
- Move all public identifiers to some type of a hash based identification
- Better error messages in the games responses

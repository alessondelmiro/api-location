# API Location

### Prerequisites

1. ruby ruby-2.6.3
2. Postgres: 12.x

### Getting started

1. Code:
```sh
$ git clone https://github.com/alessondelmiro/api-location.git
$ cd api-location
```

2. Dependencies:
```sh
$ gem install rails
$ gem install bundler
$ bundle install
```

3. Database:
```sh
$ rake db:create db:migrate
```

4. Running:
```sh
$ rails s
```

Access your server at http://localhost:3000/

### Test suite
    
1. Run everything:
```sh
$ rspec .
```
2. Run one model
```sh
$ rspec spec/models/your_model.rb
```
3. Run one request
```sh
bundle exec spring rspec spec/requests/api/v1/your_request.rb
```

### Deploy to Heroku

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy) 

### Postman

[Documentation](https://documenter.getpostman.com/view/1117525/TVK77fwH)

[![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/caf4476b81d7bb49190a#?env%5Bprod%5D=W3sia2V5IjoiaG9zdCIsInZhbHVlIjoiaHR0cHM6Ly9hcGktbG9jYXRpb24uaGVyb2t1YXBwLmNvbSIsImVuYWJsZWQiOnRydWV9XQ==)

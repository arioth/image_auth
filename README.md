# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version: 2.4.1

* System dependencies
  - Redis
  - PostgreSQL

* Configuration
  - Copy the .env.test in a new file named .env.development
  - Change the variables with your own information

* Database creation
  - bundle exec rails db:create
  - bundle exec rails db:migrate

* How to run the test suite
  - bundle exec rspec

* Services (job queues, cache servers, search engines, etc.)
  - bundle exec sidekiq -q mailers
  
* How to run the server
  - bundle exec puma -C config/puma.rb

* Deployment instructions
  - cap production deploy

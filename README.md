# Embloggen

A Rails application for turning tweetstorms into blog posts.

# Setup

  1. Download your tweet archive from Twitter. You'll need the tweets.csv file that comes in that package.
  1. Clone the repo.
  1. Install Ruby 2.2.3.
  1. Install postgresql.
  1. `gem install bundler`
  1. `bundle install`
  1. Edit `config/database.yml` if you don't want to use the default pg user & password.
  1. `rake db:create`
  1. `rake db:migrate`
  1. `rails console`
  1. In the console, run `TweetImporter.load_archive("/full/path/to/tweets.csv")`.
  1. Exit the Rails console.
  1. `rails server`
  1. Visit http://localhost:3000 to see a list of all the roots of your tweetstorms.
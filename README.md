# Embloggen

A Rails application for turning tweetstorms into blog posts.

# Setup

  # Download your tweet archive from Twitter. You'll need the tweets.csv file that comes in that package.
  # Clone the repo.
  # Install Ruby 2.2.3.
  # Install postgresql.
  # `gem install bundler`
  # `bundle install`
  # Edit `config/database.yml` if you don't want to use the default pg user & password.
  # `rake db:create`
  # `rake db:migrate`
  # `rails console`
  # In the console, run `TweetImporter.load_archive("/full/path/to/tweets.csv")`.
  # Exit the Rails console.
  # `rails server`
  # Visit http://localhost:3000 to see a list of all the roots of your tweetstorms.

# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

task :import_tweets, [:path] do |t, args|
  # syntax for using these in the command line is `rake import_tweets['path/to/tweets.csv']`
  TweetImporter.load_archive(args[:path])
end

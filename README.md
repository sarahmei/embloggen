# Embloggen

A Rails application for turning your tweetstorms into blog posts.

### How to get it going locally

  1. Download your tweet archive from Twitter from [Account Settings][1]. You'll need the tweets.csv file that comes in that package.
  1. Clone the repo.
  1. Install Ruby 2.2.3.
  1. Install postgresql.
  1. `gem install bundler`
  1. `bundle install`
  1. Edit `config/database.yml` if you don't want to use the default pg user & password.
  1. `rake db:create`
  1. `rake db:migrate`
  1. `rake import_tweets['path/to/tweets.csv']` replacing 'path/to/tweets.csv' with the actual path to the CSV file.
  1. `rails server`
  1. Visit http://localhost:3000 to see a list of all the roots of your tweetstorms. Roots are defined as tweets that are:
      * from you
      * not in reply to another tweet
      * that you replied to
  1. Choose a tweetstorm and select "See whole storm" to see the reply chain rooted at that tweet.
  1. From that page, select "Make a draft" at the bottom. This puts all the tweets in that storm into a textbox, separated by newlines, where they can be copied out into a real editor somewhere.

If you'd like to be able to add tweets that are newer than your archive to the database, you'll additionally need to do the following:

  1. Go to https://apps.twitter.com/app/new to make a new twitter app for your local version of Embloggen. You don't need to give it a real website and you can leave callback URL blank.
  1. Once you've created an app, you'll see its consumer key and consumer secret. Copy those into your `~/.bash-profile`:
```
export EMBLOGGEN_TWITTER_CONSUMER_KEY="your consumer key here"
export EMBLOGGEN_TWITTER_CONSUMER_SECRET="your consumer secret here"
```
  1. Lower down on the management page you'll see a way to create an access token and access token secret. Do that and then copy them into your `~/.bash-profile` too:
```
export EMBLOGGEN_TWITTER_ACCESS_TOKEN="your access token here"
export EMBLOGGEN_TWITTER_ACCESS_TOKEN_SECRET="your access token secret here"
```
  1. You may need to open a new shell to get those exports. Once you have them though you'll be able to use the "Refresh my thoughts" link on the homepage to fetch new tweets.

### Wish List

  1. Less ugly.
  1. ~~Mark tweetstorms Not Interested or "I've already led those thoughts", so they don't show up in the list anymore.~~
  1. Save/edit a draft attached to a storm.
  1. See back versions of a saved draft.
  1. Connect to Medium to create a draft there.
  1. Connect to Wordpress to make a draft there.
  1. ~~Update the archive via API.~~
  1. Import ~~/update~~ through the UI.
  1. See other people's recent tweetstorms via API.
  1. See mentions (from other people) alongside the tweetstorm, via API.
  1. Support multiple users?

### License

MIT - see LICENSE.md.

### Code of Conduct

The project has one! Please see CODE_OF_CONDUCT.md for details. By participating in this project, you agree to abide by its terms.

[1]: https://twitter.com/settings/account

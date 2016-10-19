class TimelineUpdater
  attr_reader :client, :since

  def initialize(options = {})
    @since = options[:since] || Tweet.most_recent || NilTweet.new
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["EMBLOGGEN_TWITTER_CONSUMER_KEY"]
      config.consumer_secret = ENV["EMBLOGGEN_TWITTER_CONSUMER_SECRET"]
      config.access_token = ENV["EMBLOGGEN_TWITTER_ACCESS_TOKEN"]
      config.access_token_secret = ENV["EMBLOGGEN_TWITTER_ACCESS_TOKEN_SECRET"]
    end
  end

  def run
    api_tweets = client.user_timeline(count: 200, since_id: since.tweet_identifier)
    api_tweets.each do |api_tweet|
      tweet_attributes = {
        original_timestamp: api_tweet.created_at,
        original_client: api_tweet.source,
        text: api_tweet.text,
        in_reply_to_identifier: api_tweet.in_reply_to_tweet_id,
        in_reply_to_user_identifier: api_tweet.in_reply_to_user_id,
        expanded_urls: api_tweet.uris.map(&:expanded_url).join(',')
      }
      if api_tweet.retweeted_tweet.present?
        tweet_attributes.merge!({
                                  retweeted_tweet_identifier: api_tweet.retweeted_tweet.id,
                                  retweeted_tweet_user_identifier: api_tweet.retweeted_tweet.user.id,
                                  retweeted_tweet_original_timestamp: api_tweet.retweeted_tweet.created_at,
                                })
      end
      Tweet.create_with(tweet_attributes).find_or_create_by(tweet_identifier: api_tweet.id)
    end
  end
end

class NilTweet
  def tweet_identifier
    nil
  end
end
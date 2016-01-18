class Tweet < ActiveRecord::Base
  validates_presence_of :tweet_identifier, :original_timestamp, :original_client, :text
  validates_uniqueness_of :tweet_identifier

  def replies
    Tweet.where(in_reply_to_identifier: self.tweet_identifier)
  end

  def self.originating
    where("tweets.in_reply_to_identifier IS NULL AND tweets.retweeted_tweet_identifier IS NULL")
  end

  def self.with_replies
    joins("JOIN tweets AS t2 ON t2.in_reply_to_identifier = tweets.tweet_identifier")
  end
end
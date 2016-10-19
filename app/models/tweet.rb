class Tweet < ActiveRecord::Base
  validates_presence_of :tweet_identifier, :original_timestamp, :original_client, :text
  validates_uniqueness_of :tweet_identifier

  def self.most_recent
    order(original_timestamp: :desc).limit(1).first
  end

  def self.originating
    where("tweets.in_reply_to_identifier IS NULL AND tweets.retweeted_tweet_identifier IS NULL")
  end

  def self.with_replies
    joins("JOIN tweets AS t2 ON t2.in_reply_to_identifier = tweets.tweet_identifier")
  end

  def self.active_tweet_storms
    originating.with_replies.distinct.where(hidden: false)
  end

  def replies
    Tweet.where(in_reply_to_identifier: self.tweet_identifier)
  end

  def reply_chain
    chain = []
    current_reply_set = self.replies
    while current_reply_set.any?
      first_reply = current_reply_set.first
      chain << first_reply
      current_reply_set = first_reply.replies
    end
    return chain
  end

  def formatted_text
    CGI.unescapeHTML(self.text)
  end

  def formatted_original_timestamp
    self.original_timestamp.in_time_zone('Pacific Time (US & Canada)').to_formatted_s(:long)
  end
end
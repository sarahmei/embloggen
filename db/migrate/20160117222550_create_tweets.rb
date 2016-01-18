class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :tweet_identifier
      t.string :in_reply_to_identifier
      t.string :in_reply_to_user_identifier
      t.datetime :original_timestamp
      t.string :original_client
      t.text :text
      t.string :retweeted_tweet_identifier
      t.string :retweeted_tweet_user_identifier
      t.datetime :retweeted_tweet_original_timestamp
      t.text :expanded_urls
      t.timestamps
    end
  end
end

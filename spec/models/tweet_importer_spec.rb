require 'rails_helper'

describe TweetImporter do
  describe ".load_archive" do
    describe "a 'normal' tweet that isn't a reply or a retweet" do
      let(:standalone_file) { File.expand_path("../../support/standalone_tweet.csv", __FILE__) }

      it "creates a Tweet" do
        expect {
          TweetImporter.load_archive(standalone_file)
        }.to change {
          Tweet.count
        }.from(0).to(1)
      end

      it "imports the right tweet identifier" do
        TweetImporter.load_archive(standalone_file)
        tweet = Tweet.first
        expect(tweet.tweet_identifier).to eq("apple")
      end

      it "does not assign a reply-to tweet identifier" do
        TweetImporter.load_archive(standalone_file)
        tweet = Tweet.first
        expect(tweet.in_reply_to_identifier).to be_nil
      end

      it "does not assign a reply-to user identifier" do
        TweetImporter.load_archive(standalone_file)
        tweet = Tweet.first
        expect(tweet.in_reply_to_user_identifier).to be_nil
      end

      it "imports the original timestamp" do
        TweetImporter.load_archive(standalone_file)
        tweet = Tweet.first
        expect(tweet.original_timestamp).to eq("2016-01-17 19:08:15.000000000 +0000")
      end

      it "imports the original client string" do
        TweetImporter.load_archive(standalone_file)
        tweet = Tweet.first
        expect(tweet.original_client).to eq("some random twitter client")
      end

      it "imports the text of the tweet" do
        TweetImporter.load_archive(standalone_file)
        tweet = Tweet.first
        expect(tweet.text).to eq("mimosas at brunch! https://example.com/the-fake-url")
      end

      it "does not assign a retweeted tweet identifier" do
        TweetImporter.load_archive(standalone_file)
        tweet = Tweet.first
        expect(tweet.retweeted_tweet_identifier).to be_nil
      end

      it "does not assign a retweeted tweet user identifier" do
        TweetImporter.load_archive(standalone_file)
        tweet = Tweet.first
        expect(tweet.retweeted_tweet_user_identifier).to be_nil
      end

      it "does not assign a retweeted tweet timestamp" do
        TweetImporter.load_archive(standalone_file)
        tweet = Tweet.first
        expect(tweet.retweeted_tweet_original_timestamp).to be_nil
      end

      it "imports the right expanded URLs" do
        TweetImporter.load_archive(standalone_file)
        tweet = Tweet.first
        expect(tweet.expanded_urls).to eq("https://example.com/the-real-url")
      end
    end
    
    describe "a tweet that is a reply but not a retweet" do
      let(:reply_not_retweet_file) { File.expand_path("../../support/reply_not_retweet_tweet.csv", __FILE__) }

      it "creates a Tweet" do
        expect {
          TweetImporter.load_archive(reply_not_retweet_file)
        }.to change {
          Tweet.count
        }.from(0).to(1)
      end

      it "imports the right tweet identifier" do
        TweetImporter.load_archive(reply_not_retweet_file)
        tweet = Tweet.first
        expect(tweet.tweet_identifier).to eq("orange")
      end

      it "imports the right reply-to tweet identifier" do
        TweetImporter.load_archive(reply_not_retweet_file)
        tweet = Tweet.first
        expect(tweet.in_reply_to_identifier).to eq("tangerine")
      end

      it "imports the right reply-to user identifier" do
        TweetImporter.load_archive(reply_not_retweet_file)
        tweet = Tweet.first
        expect(tweet.in_reply_to_user_identifier).to eq("grapefruit")
      end

      it "imports the original timestamp" do
        TweetImporter.load_archive(reply_not_retweet_file)
        tweet = Tweet.first
        expect(tweet.original_timestamp).to eq("2016-01-17 19:18:39 +0000")
      end

      it "imports the original client string" do
        TweetImporter.load_archive(reply_not_retweet_file)
        tweet = Tweet.first
        expect(tweet.original_client).to eq("some random twitter client")
      end

      it "imports the text of the tweet" do
        TweetImporter.load_archive(reply_not_retweet_file)
        tweet = Tweet.first
        expect(tweet.text).to eq("@jack <3 https://example.com/the-fake-url")
      end

      it "does not assign a retweeted tweet identifier" do
        TweetImporter.load_archive(reply_not_retweet_file)
        tweet = Tweet.first
        expect(tweet.retweeted_tweet_identifier).to be_nil
      end

      it "does not assign a retweeted tweet user identifier" do
        TweetImporter.load_archive(reply_not_retweet_file)
        tweet = Tweet.first
        expect(tweet.retweeted_tweet_user_identifier).to be_nil
      end

      it "does not assign a retweeted tweet timestamp" do
        TweetImporter.load_archive(reply_not_retweet_file)
        tweet = Tweet.first
        expect(tweet.retweeted_tweet_original_timestamp).to be_nil
      end

      it "imports the right expanded URLs" do
        TweetImporter.load_archive(reply_not_retweet_file)
        tweet = Tweet.first
        expect(tweet.expanded_urls).to eq("https://example.com/the-real-url")
      end
    end

    describe "a tweet that is a retweet but not a reply" do
      let(:retweet_not_reply_file) { File.expand_path("../../support/retweet_not_reply_tweet.csv", __FILE__) }

      it "creates a Tweet" do
        expect {
          TweetImporter.load_archive(retweet_not_reply_file)
        }.to change {
          Tweet.count
        }.from(0).to(1)
      end

      it "imports the right tweet identifier" do
        TweetImporter.load_archive(retweet_not_reply_file)
        tweet = Tweet.first
        expect(tweet.tweet_identifier).to eq("fuji")
      end

      it "does not assign a reply-to tweet identifier" do
        TweetImporter.load_archive(retweet_not_reply_file)
        tweet = Tweet.first
        expect(tweet.in_reply_to_identifier).to be_nil
      end

      it "does not assign a reply-to user identifier" do
        TweetImporter.load_archive(retweet_not_reply_file)
        tweet = Tweet.first
        expect(tweet.in_reply_to_user_identifier).to be_nil
      end

      it "imports the original timestamp" do
        TweetImporter.load_archive(retweet_not_reply_file)
        tweet = Tweet.first
        expect(tweet.original_timestamp).to eq("2016-01-17 19:06:28 +0000")
      end

      it "imports the original client string" do
        TweetImporter.load_archive(retweet_not_reply_file)
        tweet = Tweet.first
        expect(tweet.original_client).to eq("some random twitter client")
      end

      it "imports the text of the tweet" do
        TweetImporter.load_archive(retweet_not_reply_file)
        tweet = Tweet.first
        expect(tweet.text).to eq("RT @jack: Super deep statement everyone should read https://example.com/the-fake-url")
      end

      it "imports the right retweeted tweet identifier" do
        TweetImporter.load_archive(retweet_not_reply_file)
        tweet = Tweet.first
        expect(tweet.retweeted_tweet_identifier).to eq("gala")
      end

      it "imports the right retweeted tweet user identifier" do
        TweetImporter.load_archive(retweet_not_reply_file)
        tweet = Tweet.first
        expect(tweet.retweeted_tweet_user_identifier).to eq("pink lady")
      end

      it "imports the retweeted tweet timestamp" do
        TweetImporter.load_archive(retweet_not_reply_file)
        tweet = Tweet.first
        expect(tweet.retweeted_tweet_original_timestamp).to eq("2016-01-17 18:43:42.000000000 +0000")
      end

      it "imports the right expanded URLs" do
        TweetImporter.load_archive(retweet_not_reply_file)
        tweet = Tweet.first
        expect(tweet.expanded_urls).to eq("https://example.com/the-real-url")
      end
    end
  end
end
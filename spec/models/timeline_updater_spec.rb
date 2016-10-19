require "rails_helper"

describe TimelineUpdater do
  describe "#run" do
    let(:timestamp) { 3.days.ago.to_s }
    before do
      allow_any_instance_of(Twitter::REST::Client).
        to receive(:user_timeline).
          and_return([
                       Twitter::Tweet.new(
                         id: "banana",
                         created_at: timestamp,
                         source: "a random twitter client",
                         text: "omg mimosas http://shortened.url",
                         in_reply_to_status_id: "tangelo",
                         in_reply_to_user_id: "helicopter",
                         entities: {
                           urls: [
                             {
                               url: "http://shortened.url",
                               expanded_url: "http://expanded.url",
                               display_url: "shortened.url",
                               indices: [12]
                             }
                           ]
                         },
                         retweeted_status: {
                           id: "grapefruit",
                           user: { id: "airplane" },
                           created_at: timestamp,
                           text: "brunchin"
                         }
                       )
                     ])
    end

    it "makes tweets from the api response" do
      expect {
        TimelineUpdater.new.run
      }.to change {
        Tweet.count
      }.by(1)
    end

    it "includes the right attributes" do
      TimelineUpdater.new.run
      tweet = Tweet.last
      expect(tweet.tweet_identifier).to eq("banana")
      expect(tweet.original_timestamp).to eq(timestamp)
      expect(tweet.original_client).to eq("a random twitter client")
      expect(tweet.text).to eq("omg mimosas http://shortened.url")
      expect(tweet.in_reply_to_identifier).to eq("tangelo")
      expect(tweet.in_reply_to_user_identifier).to eq("helicopter")
      expect(tweet.retweeted_tweet_identifier).to eq("grapefruit")
      expect(tweet.retweeted_tweet_user_identifier).to eq("airplane")
      expect(tweet.retweeted_tweet_original_timestamp).to eq(timestamp)
      expect(tweet.expanded_urls).to eq("http://expanded.url")
    end

    describe "when there's already a tweet with that identifier" do
      before do
        @tweet = create(:tweet, tweet_identifier: "banana", text: "not about mimosas")
      end

      it "does not make a new tweet" do
        expect {
          TimelineUpdater.new.run
        }.to_not change { Tweet.count }
      end

      it "does not update existing tweet with new info" do
        expect {
          TimelineUpdater.new.run
        }.to_not change { @tweet.reload.text }
      end
    end

    describe "how it uses the twitter api" do
      it "calls the twitter api" do
        expect_any_instance_of(Twitter::REST::Client).to receive(:user_timeline).and_return([])
        TimelineUpdater.new.run
      end

      it "asks for 200 tweets" do
        expect_any_instance_of(Twitter::REST::Client).to receive(:user_timeline)
                                                           .with(hash_including(count: 200))
                                                           .and_return([])
        TimelineUpdater.new.run
      end

      context "when no tweet identifier is provided" do
        context "and there's at least one tweet in the db" do
          let(:tweet) { create(:tweet) }

          it "asks for tweets that are newer than the most recent in the database" do
            allow(Tweet).to receive(:most_recent).and_return(tweet)

            expect_any_instance_of(Twitter::REST::Client).to receive(:user_timeline)
                                                               .with(hash_including(since_id: tweet.tweet_identifier))
                                                               .and_return([])
            TimelineUpdater.new.run
          end
        end

        context "and this is our first run" do
          it "does not specify a starting point for tweets" do
            expect_any_instance_of(Twitter::REST::Client).to receive(:user_timeline)
                                                               .with(hash_including(since_id: nil))
                                                               .and_return([])
            TimelineUpdater.new.run
          end
        end
      end

      context "when a tweet identifier is provided" do
        it "asks for tweets since that tweet" do
          2.times { create(:tweet) }
          specified_tweet = create(:tweet, original_timestamp: 4.months.ago)

          expect_any_instance_of(Twitter::REST::Client).to receive(:user_timeline)
                                                             .with(hash_including(since_id: specified_tweet.tweet_identifier))
                                                             .and_return([])
          TimelineUpdater.new(since: specified_tweet).run
        end
      end
    end
  end
end
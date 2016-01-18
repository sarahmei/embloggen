require "rails_helper"

describe Tweet do
  describe "validations" do
    subject { create(:tweet) }

    it { should validate_presence_of :tweet_identifier }
    it { should validate_presence_of :original_timestamp }
    it { should validate_presence_of :original_client }
    it { should validate_presence_of :text }

    it { should validate_uniqueness_of :tweet_identifier }
  end

  it "factories up a valid tweet" do
    expect(create(:tweet)).to be_valid
  end

  describe ".originating" do
    it "returns tweets that are not replies to other tweets" do
      2.times { create(:reply) }
      originating = create(:tweet)
      3.times { create(:retweet) }

      expect(Tweet.originating).to eq([originating])
    end
  end

  describe ".with_replies" do
    it "returns only tweets that have replies" do
      2.times { create(:tweet) }

      storm = create(:tweet)
      first_reply = create(:reply, in_reply_to_identifier: storm.tweet_identifier)
      second_reply = create(:reply, in_reply_to_identifier: first_reply.tweet_identifier)

      expect(Tweet.with_replies).to eq([storm, first_reply])
    end
  end
end
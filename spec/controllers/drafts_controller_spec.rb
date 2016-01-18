require "rails_helper"

describe DraftsController do
  describe "GET #index" do
    it "succeeds" do
      get :index
      expect(response.response_code).to eq(200)
    end

    it "assigns a list of originating tweets" do
      create(:tweet)

      older_storm = create(:tweet, original_timestamp: 6.weeks.ago)
      create(:reply, in_reply_to_identifier: older_storm.tweet_identifier)

      storm = create(:tweet, original_timestamp: 4.days.ago)
      create(:reply, in_reply_to_identifier: storm.tweet_identifier)

      get :index
      expect(assigns(:originating_tweets)).to eq([storm, older_storm])
    end
  end
end
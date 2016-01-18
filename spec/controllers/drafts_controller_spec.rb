require "rails_helper"

describe DraftsController do
  describe "GET #index" do
    it "succeeds" do
      get :index
      expect(response.response_code).to eq(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "assigns a list of originating tweets with newest first" do
      create(:tweet)
      older_storm = create(:tweet_storm, original_timestamp: 6.weeks.ago)
      storm = create(:tweet_storm, original_timestamp: 4.days.ago)

      get :index
      expect(assigns(:originating_tweets)).to eq([storm, older_storm])
    end
  end

  describe "GET #show" do
    let(:root) { create(:tweet_storm) }

    it "succeeds" do
      get :show, id: root.id
      expect(response.response_code).to eq(200)
    end

    it "renders the show template" do
      get :show, id: root.id
      expect(response).to render_template(:show)
    end

    it "assigns the root" do
      get :show, id: root.id
      expect(assigns(:root)).to eq(root)
    end

    it "assigns the chain of direct replies" do
      first_reply = Tweet.where(in_reply_to_identifier: root.tweet_identifier).first
      second_reply = create(:reply, in_reply_to_identifier: first_reply.tweet_identifier)
      third_reply = create(:reply, in_reply_to_identifier: second_reply.tweet_identifier)

      get :show, id: root.id
      expect(assigns(:reply_chain)).to eq([first_reply, second_reply, third_reply])
    end
  end
end
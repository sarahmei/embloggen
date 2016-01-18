require "rails_helper"

describe DraftsController do
  describe "GET #new" do
    let(:storm) { create(:tweet_storm) }

    before do
      @first_reply = Tweet.where(in_reply_to_identifier: storm.tweet_identifier).first
      @second_reply = create(:reply, in_reply_to_identifier: @first_reply.tweet_identifier)
      @third_reply = create(:reply, in_reply_to_identifier: @second_reply.tweet_identifier)
    end

    it "succeeds" do
      get :new, root_id: storm.id
      expect(response.response_code).to eq(200)
    end

    it "renders the new template" do
      get :new, root_id: storm.id
      expect(response).to render_template(:new)
    end

    it "assigns the root" do
      get :new, root_id: storm.id
      expect(assigns(:root)).to eq(storm)
    end

    it "assigns the reply chain" do
      get :new, root_id: storm.id
      expect(assigns(:reply_chain)).to eq([@first_reply, @second_reply, @third_reply])
    end

    it "assigns the draft" do
      get :new, root_id: storm.id
      expect(assigns(:draft)).to eq("#{storm.text}\n\n#{@first_reply.text}\n\n#{@second_reply.text}\n\n#{@third_reply.text}")
    end
  end
end
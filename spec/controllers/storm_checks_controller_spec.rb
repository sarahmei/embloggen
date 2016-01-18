require "rails_helper"

describe StormChecksController do
  describe "POST #create" do
    before do
      allow_any_instance_of(Twitter::REST::Client).to receive(:user_timeline).and_return([])
    end

    it "redirects to the storm index" do
      post :create
      expect(response).to redirect_to(storms_path)
    end

    it "updates the timeline" do
      expect_any_instance_of(TimelineUpdater).to receive(:run)
      post :create
    end
  end
end
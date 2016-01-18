class DraftsController < ApplicationController
  def index
    @originating_tweets = Tweet.originating.with_replies.order(original_timestamp: :desc)
    render :index
  end
end
class StormsController < ApplicationController
  def index
    @originating_tweets = Tweet.originating.with_replies.order(original_timestamp: :desc)
    render :index
  end

  def show
    @root = Tweet.find(params[:id])
    @reply_chain = []
    current_reply_set = @root.replies
    while current_reply_set.any?
      first_reply = current_reply_set.first
      @reply_chain << first_reply
      current_reply_set = first_reply.replies
    end
    render :show
  end
end
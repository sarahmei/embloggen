class StormsController < ApplicationController
  def index
    @originating_tweets = Tweet.originating.with_replies.order(original_timestamp: :desc)
    render :index
  end

  def show
    @root = Tweet.find(params[:id])
    @reply_chain = @root.reply_chain
    render :show
  end
end
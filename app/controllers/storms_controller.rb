class StormsController < ApplicationController
  def index
    @originating_tweets = Tweet.active_tweet_storms.order(original_timestamp: :desc)
    render :index
  end

  def show
    @root = Tweet.find(params[:id])
    @reply_chain = @root.reply_chain
    render :show
  end

  def destroy
    root = Tweet.find(params[:id])
    root.hidden = true
    root.save!
    redirect_to storms_path
  end
end
class DraftsController < ApplicationController
  def new
    @root = Tweet.find(params[:root_id])
    @reply_chain = @root.reply_chain
    @draft = @reply_chain.map(&:formatted_text).prepend(@root.formatted_text).join("\n\n")
  end
end
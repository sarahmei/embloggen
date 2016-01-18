class StormChecksController < ApplicationController
  def create
    TimelineUpdater.new.run
    redirect_to storms_path
  end
end
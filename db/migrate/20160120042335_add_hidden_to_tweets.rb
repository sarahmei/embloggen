class AddHiddenToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :hidden, :boolean, default: false
  end
end

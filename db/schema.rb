# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160117222550) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "tweets", force: :cascade do |t|
    t.string   "tweet_identifier"
    t.string   "in_reply_to_identifier"
    t.string   "in_reply_to_user_identifier"
    t.datetime "original_timestamp"
    t.string   "original_client"
    t.text     "text"
    t.string   "137128333140963328"
    t.string   "retweeted_tweet_user_identifier"
    t.datetime "retweeted_tweet_original_timestamp"
    t.text     "expanded_urls"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

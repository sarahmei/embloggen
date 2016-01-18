require "csv"

class TweetImporter
  def self.load_archive(archive_file)
    CSV.foreach(archive_file, encoding: Encoding::UTF_8, headers: :first_row) do |row|
      Tweet.create!(
        tweet_identifier: row[0],
        in_reply_to_identifier: row[1].empty? ? nil : row[1],
        in_reply_to_user_identifier: row[2].empty? ? nil: row[2],
        original_timestamp: row[3],
        original_client: row[4],
        text: row[5],
        retweeted_tweet_identifier: row[6].empty? ? nil: row[6],
        retweeted_tweet_user_identifier: row[7].empty? ? nil : row[7],
        retweeted_tweet_original_timestamp: row[8],
        expanded_urls: row[9]
      )
    end
  end
end
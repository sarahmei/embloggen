FactoryGirl.define do
  factory :tweet do
    sequence(:tweet_identifier) { |n| "identifier#{n}" }
    original_timestamp { 2.days.ago }
    original_client { "discontinued awesome client" }
    text { "poopin" }

    factory :reply do
      sequence(:in_reply_to_identifier) { |n| "reply_identifier#{n}" }
      sequence(:in_reply_to_user_identifier) { |n| "user_identifier#{n}" }
    end

    factory :retweet do
      sequence(:retweeted_tweet_identifier) { |n| "retweeted_identifier#{n}" }
      sequence(:retweeted_tweet_user_identifier) { |n| "rt_user_identifier#{n}" }
      retweeted_tweet_original_timestamp { 4.days.ago }
    end

    factory :tweet_storm do
      after(:create) do |tweet, evaluator|
        create(:reply, in_reply_to_identifier: tweet.tweet_identifier)
      end
    end
  end
end
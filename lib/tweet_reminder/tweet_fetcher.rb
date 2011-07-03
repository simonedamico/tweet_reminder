module TweetReminder
  class TweetFetcher
    
    def initialize(twitter, fetched_tweets)
      @twitter = twitter
      @fetched_tweets = fetched_tweets
      @last_direct_id = 1
      @last_mention_id = 1
    end
    
    def fetch_direct_tweets
      @twitter.direct_messages({since_id: @last_direct_id}).reverse.each do |tweet|
          if tweet.id > @last_direct_id
            save_tweet(tweet)
            @last_direct_id = tweet.id
          end
      end
    end
    
    def fetch_mention_tweets
      @twitter.mentions({since_id: @last_mention_id}).reverse.each do |tweet|
          if tweet.id > @last_mention_id
            save_tweet(tweet)
            @last_mention_id = tweet.id
          end
      end
    end
    
    def fetch_tweets
      fetch_direct_tweets
      fetch_mention_tweets
    end
    
    def save_tweet(tweet)
      #tweet.send_screen_name for direct tweets, so if is nil I assume is a mention
      @fetched_tweets << { sender: (tweet.sender_screen_name or tweet.user.screen_name),
                          text: tweet.text,
                          id: tweet.id,
                          date: tweet.created_at }
    end
  end
end
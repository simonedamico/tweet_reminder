require 'yaml'
require 'twitter'

module TweetReminder
  class Bot
    
    attr_accessor :twitter_credentials
    
    def initialize(output)
      @output = output
      @interrupted = false
      trap("INT") { @interrupted = true }
      
      @last_direct_id = 1
      @last_mention_id = 1
      
    end
    
    def start
      load_conf
      setup_twitter
      loop do
        fetch_direct_tweets
        fetch_mention_tweets        
        process_tweets
        
        exit if @interrupted
      end
    end
    
    def load_conf
      yaml = YAML::load(File.open('conf/bot.yaml'))
      @twitter_credentials = yaml['twitter']
      @output.puts('Configuration loaded.')
    end
    
    def setup_twitter
      Twitter.configure do |config|
        config.consumer_key = @twitter_credentials['consumer_key']
        config.consumer_secret = @twitter_credentials['consumer_secret']
        config.oauth_token = @twitter_credentials['oauth_token']
        config.oauth_token_secret = @twitter_credentials['oauth_secret']
      end
    end
    
    def process_tweets
      while(tweet = @fetched_tweets.shift)
        puts tweet[:text]
      end
    end
    
    def fetch_direct_tweets
      Twitter.direct_messages({since_id: @last_direct_id}).reverse.each do |tweet|
          if tweet.id > @last_direct_id
            save_tweet(tweet)
            @last_direct_id = tweet.id
          end
      end
    end
    
    def fetch_mention_tweets
      Twitter.mentions({since_id: @last_mention_id}).reverse.each do |tweet|
          if tweet.id > @last_mention_id
            save_tweet(tweet)
            @last_mention_id = tweet.id
          end
      end
    end
    
    def fetched_tweets
      @fetched_tweets ||= []
    end
    
    def save_tweet(tweet)
      fetched_tweets << { sender: tweet.sender_screen_name,
                          text: tweet.text,
                          id: tweet.id,
                          date: tweet.created_at }
    end
    
  end
end
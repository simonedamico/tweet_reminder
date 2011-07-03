require 'yaml'
require 'twitter'
require 'tweet_reminder/tweet_fetcher'
require 'tweet_reminder/tweet_sender'

module TweetReminder
  class Bot
    
    attr_accessor :twitter_credentials
    
    def initialize(output)
      @output = output
      @interrupted = false
      trap("INT") { @interrupted = true }
      @fetched_tweets = []
      @tweet_fetcher = TweetReminder::TweetFetcher.new(Twitter, @fetched_tweets)
      @outgoing_tweets = []
      @tweet_sender = TweetReminder::TweetSender.new(Twitter, @outgoing_tweets)
    end
    
    def start
      load_conf
      setup_twitter
      loop do
        fetch_tweets    
        process_tweets
        send_tweets
        
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
    
    def fetch_tweets
      @tweet_fetcher.fetch_tweets
    end
    
    def process_tweets
      while(tweet = @fetched_tweets.shift)
        tweet[:text].gsub!(/@mementme/i, 'Hey, you told me:')
        @outgoing_tweets << tweet
        puts tweet
      end
    end
    
    def send_tweets
      @tweet_sender.send_tweets      
    end
    
  end  
end
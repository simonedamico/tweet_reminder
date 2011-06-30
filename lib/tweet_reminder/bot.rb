require 'yaml'
require 'twitter'

module TweetReminder
  class Bot
    
    attr_accessor :twitter_credentials
    
    def initialize(output)
      @output = output
      @interrupted = false
      trap("INT") { @interrupted = true }
    end
    
    def start
      load_conf
      setup_twitter
      loop do
        fetch_tweets
        
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
      
    end
  end
end
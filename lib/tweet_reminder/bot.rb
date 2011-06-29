require 'yaml'

module TweetReminder
  class Bot
    
    attr_accessor :twitter_credentials
    
    def initialize(output)
      @output = output
    end
    
    def start
      load_conf
    end
    
    def load_conf
      yaml = YAML::load(File.open('conf/bot.yaml'))
      @twitter_credentials = yaml['twitter']
      @output.puts('Configuration loaded.')
    end
  end
end
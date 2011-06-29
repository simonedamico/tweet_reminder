require 'spec_helper'

module TweetReminder
  describe Bot do 
    let(:output) { double('output').as_null_object }
    let(:bot) { Bot.new(output) }
    
    describe "#load_conf" do 
      
      it "should be called when the bot start running" do
        bot.should_receive(:load_conf)
        bot.start
      end
      
      context "configuration loaded successfully" do
        it "should advertise that the conf is loaded" do
          output.should_receive(:puts).with('Configuration loaded.')
          bot.start
        end
        
        it "should have a twitter_credentials property" do
          bot.start
          bot.twitter_credentials.should be
        end
        
        it "should have a consumer key" do
          bot.start
          bot.twitter_credentials.should have_key('consumer_key')
        end
        
        it "should have a consumer secret" do
          bot.start
          bot.twitter_credentials.should have_key('consumer_secret')
        end
        
        it "should have a oauth token" do
          bot.start
          bot.twitter_credentials.should have_key('oauth_token')
        end
        
        it "should have a oauth secret" do
          bot.start
          bot.twitter_credentials.should have_key('oauth_secret')
        end
      end
    end
  end
end
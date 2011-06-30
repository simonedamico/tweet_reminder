def twitter_conf_filled_in?(configuration)
  File.open(configuration) do |file|
    file.each do |line|
      default_value = [/YOUR_CONSUMER_KEY/, /YOUR_CONSUMER_SECRET/, /YOUR_OAUTH_TOKEN/,
        /YOUR_OAUTH_SECRET/]
      
      default_value.each do |value|
        return false if line =~ value
      end
    end
  end
  
  true
end

Given /^the tweet\-reminder gem is installed correctly$/ do
  require 'tweet_reminder'
end

Given /^the twitter yaml configuration is filled\-in$/ do
  twitter_conf_filled_in?('conf/bot.yaml').should be_true
end

Given /^the twitter yaml configuration is not filled\-in$/ do
  twitter_conf_filled_in?('conf/bot.yaml.default').should_not be_true
end


When /^the sys\-admin starts the server$/ do
  pending # express the regexp above with the code you wish you had
end


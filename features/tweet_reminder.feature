Feature: fetching the tweets
  In order to schedule tweets
  As a twitter bot
  I want to fetch all tweets sended at me 

  Scenario: A user send a tweet to the bot
    Given the user "fake_user_001" sended a tweet like "@bot herp derp something"
    When the bot checks for new tweets
    Then the tweet "@bot herp derp something" must be added in a queue for processing

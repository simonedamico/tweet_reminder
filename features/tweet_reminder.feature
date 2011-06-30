Feature: Run tweet-reminder server program
  In order to create a twitter bot for scheduling events
  As a sys-admin
  I want to start tweet-reminder server
  
  Scenario: The server start successfully
    Given the tweet-reminder gem is installed correctly
    And the twitter yaml configuration is filled-in 
    When the sys-admin starts the server
    Then the server should start without any error and display "Server started."
    
  Scenario: The server cannot start beacause twitter configuration is not done
    Given the tweet-reminder gem is installed correctly
    And the twitter yaml configuration is not filled-in
    When the sys-admin starts the server
    Then the server should shut-down warning: "Twitter configuration is wrong: check out conf/bot.yaml"
    
  Scenario: The server cannot start beacause a lack of connectivity
    Given the tweet-reminder gem is installed correctly
    And the network is unreacheable
    When the sys-admin starts the server
    Then the server should shut-down warning: "Network is unreachable."
  
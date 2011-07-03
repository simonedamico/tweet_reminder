module TweetReminder
  class TweetSender
    def initialize(twitter, queue)
      @twitter = twitter
      @queue = queue
    end
    
    def send_tweets
      while tweet = @queue.pop
        Twitter.update "@#{tweet[:sender]} #{tweet[:text]}"
      end
    end
  end
end

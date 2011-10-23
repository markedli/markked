require 'twitter'

module Plugin
  class Twitter
    include Cinch::Plugin
    prefix "tweet: "

    def initialize(*args)
      super
      ::Twitter.configure do |twitter|
        twitter.consumer_key = config['twitter']['consumer_key']
        twitter.consumer_secret = config['twitter']['consumer_secret']
        twitter.oauth_token = config['twitter']['oauth_token']
        twitter.oauth_token_secret = config['twitter']['oauth_token_secret']
      end
    end

    match "mentions"
    def execute m
      ::Twitter.mentions(:count => 3).each do |tweet|
        m.reply "@#{tweet.user.screen_name}: #{tweet.text} at #{tweet.created_at}"
      end
    end

    def config
      @config ||= $file_config
    end
  end
end

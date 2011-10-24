require 'open-uri'
require 'nokogiri'

module Plugin
  class Down
    include Cinch::Plugin
    set :plugin_name => "down",
        :help => "down: <url> -- check if a website is down for everyone or just you",
        :prefix => "down: "

    match /(.+)/
    def execute(m, query)
      url = "http://downforeveryoneorjustme.com/#{query}"

      doc = Nokogiri::HTML(open(url))
      result = doc.at('div#container').text.strip.split(/\n/).first

      m.reply result
    end
  end
end

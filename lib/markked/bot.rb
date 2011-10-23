require 'cinch'

$bot = Cinch::Bot.new do
  configure do |c|
    c.server = "irc.freenode.net"
    c.channels = ["#markedli", "#markedli-dev", "#markedli-ui"]
    c.nick = "markked"
    c.realname = "Handy, dandy, helper bot."
    c.user = "markked"
  end
end

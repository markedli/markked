require 'cinch'
require 'yaml'
require 'markked/plugins/twitter'
require 'markked/plugins/down'
require 'markked/plugins/bit'
require 'markked/plugins/hell'

config = { 'irc' =>
  { 'server' => 'irc.freenode.net',
    'channels' => "#markedli, #markedli-dev, #markedli-ui",
    'nick' => 'markked',
    'realname' => "Handy, dandy, helper bot.",
    'user' => 'markked'
  }}
config_file = ARGV.shift || File.expand_path("../../../config/bot.yml", __FILE__)
if File.exists? config_file
  puts "Loading config from file: #{config_file}"
  $file_config = YAML.load_file config_file
  config['irc'].merge!($file_config['irc'])
else
  puts "No config file found"
end

$bot = Cinch::Bot.new do
  configure do |c|
    c.server = config["irc"]["server"]
    c.password = config["irc"]["password"]
    c.port = config["irc"]["port"]
    c.channels = config["irc"]["channels"].split(",")
    c.nick = config["irc"]["nick"]
    c.realname = config["irc"]["realname"]
    c.user = config["irc"]["user"]
    c.plugins.plugins = [Plugin::Twitter, Plugin::Down, Plugin::Bit, Plugin::Hell]
  end
end

trap("INT") do
  $bot.quit "Bot has been killed."
end

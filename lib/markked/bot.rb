require 'cinch'
require 'yaml'
require 'markked/plugins/twitter'
require 'markked/plugins/down'
require 'markked/plugins/bit'
require 'markked/plugins/auth'

class Hash
  #take keys of hash and transform those to a symbols
  def self.transform_keys_to_symbols(value)
    return value if not value.is_a?(Hash)
    hash = value.inject({}){|memo,(k,v)| memo[k.to_sym] = Hash.transform_keys_to_symbols(v); memo}
    return hash
  end
end

default_config = { :irc =>
  { server: 'irc.freenode.net',
    channels: "#markedli, #markedli-dev, #markedli-ui",
    nick: 'markked',
    realname: "Handy, dandy, helper bot.",
    user: 'markked'
  }}
config_file = ARGV.shift || File.expand_path("../../../config/bot.yml", __FILE__)
if File.exists? config_file
  puts "Loading config from file: #{config_file}"
  file_config = Hash.transform_keys_to_symbols YAML.load_file config_file
  file_config[:irc] = default_config[:irc].merge file_config[:irc]
else
  puts "No config file found"
end

$bot = Cinch::Bot.new do
  configure do |c|
    c.load! file_config.delete(:irc)
    c.plugins.plugins = [Plugin::Auth, Plugin::Twitter, Plugin::Down, Plugin::Bit]
    c.plugins.options[Plugin::Twitter] = file_config.delete(:twitter)
  end
end

trap("INT") do
  $bot.quit "Bot has been killed."
end

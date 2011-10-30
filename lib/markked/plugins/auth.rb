
module Plugin
  class Auth
    include Cinch::Plugin
    class RegisteredUser < Struct.new(:hosts, :password); end
    set :plugin_name => "auth",
        :help => "auth: register <password>",
        :prefix => "auth: "
    def initialize *args
      super
      @registered_users = {}
    end

    match /register (.+)/, :method => :register
    def register m, password
      @registered_users[m.user.nick] = RegisteredUser.new([m.user.host], password)
      m.reply "Registered #{m.user.nick} with host #{m.user.host}"
    end

    match /registered/, :method => :registered
    def registered m
      if @registered_users.key?(m.user.nick) && @registered_users[m.user.nick].hosts.include?(m.user.host)
        m.reply "#{m.user.nick} is registered with host #{m.user.host}"
      elseif @registered_users.key?(m.user.nick)
        m.reply "#{m.user.nick} is registered with another host"
      else
        m.reply "#{m.user.nick} is not registered"
      end
    end
  end
end

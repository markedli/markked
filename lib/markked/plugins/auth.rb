require 'singleton'

class Authorization
  include Singleton
  class RegisteredUser < Struct.new(:hosts, :password, :current_user); end
  attr_reader :registered_users

  def initialize 
    @registered_users = {}
  end

  def register nick, host, password
    @registered_users[nick] = RegisteredUser.new([host], password, nil)
  end
  def login user, password
    registered_user = @registered_users[user.nick]
    return "#{user.nick} is not registered" if registered_user.nil?
    if registered_user.password == password
      @registered_users[user.nick].current_user = user
      return "you are now logged in"
    end
    return "#{user.nick} could not be authenticated with that password"
  end
  def logged_in? user
    (@registered_users.key?(user.nick) && @registered_users[user.nick].current_user)
  end
  def logout user
    if logged_in? user
      @registered_users[user.nick].current_user = nil
      return "#{user.nick} logged out"
    end
    return "that user is not logged in"
  end
end

module Plugin
  class Auth
    include Cinch::Plugin
    set :plugin_name => "auth",
        :help => "auth: register <password>",
        :prefix => "auth: ",
        :required_options => [:auth]

    match /register (.+)/, :method => :register
    def register m, password
      config[:auth].register m.user.nick, m.user.host, password
      m.reply "Registered #{m.user.nick} with host #{m.user.host}"
    end
    match /login (.+)/, :method => :login
    def login m, password
      m.reply config[:auth].login m.user, password
    end
    match /authenticated/, :method => :authenticated
    def authenticated m
      m.reply config[:auth].logged_in? m.user
    end
    match /logout/, :method => :logout
    def logout m
      m.reply config[:auth].logout m.user
    end
  end
end

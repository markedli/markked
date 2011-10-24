module Plugin
  class Hell
    include Cinch::Plugin
    set :plugin_name => "hell",
        :help => "send that thing to hell",
        :prefix => "hell: "

    def initialize(*args)
      super
      @damned = []
    end
    listen_to :message, :action
    match /(.+) to hell/, :use_prefix => false
    def execute(m, damned)
      damned = m.action_message.match(/(.+) to hell/) if m.action?
      return unless damned.start_with?( "feed", "send", "damn", "punt", "toss", "smite", "condemn", "hurl", "throw", "kick", "cast", "banish")
      parts = damned.split(" ")
      parts.delete_at(0)
      damned = parts.join(" ")
      m.reply "swallows #{damned}"
      @damned << damned
    end

    match "count", :method => :count
    def count m
      m.reply "currently #{@damned.count} damned souls", true
    end
  end
end

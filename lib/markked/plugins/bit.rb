module Plugin
  class Bit
    include Cinch::Plugin
    set :plugin_name => "bit",
        :help => "bit is a decision bot, address it with a question",
        :prefix => "bit: "
    
    match /(.+)\?/
    def execute(m, question)
      answers = question.split(", ")
      answers.map! { |answer| answer.split(" or ") }
      answers.flatten!.map! { |a| a.strip }
      answers = ["yes", "no"] unless answers.count > 1
      m.reply answers.shuffle.pop, true
    end
  end
end

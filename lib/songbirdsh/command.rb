module Songbirdsh
  module Command
    def classify name
      name.to_s.split('_').map{|s|s.capitalize}.join
    end

    def load_command name, *args
      require "songbirdsh/command/#{name}"
      Songbirdsh::Command.const_get(classify(name)).new *args
    end
  end
end
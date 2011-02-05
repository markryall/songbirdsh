module Songbirdsh
  class Command
    def self.load name, *args
      require "songbirdsh/command/#{name}"
      classname = name.to_s.split('_').map{|s|s.capitalize}.join
      Songbirdsh::Command.const_get(classname).new *args
    end

    def initialize player
      @player = player
    end
  end
end
module Songbirdsh
  module Command
    def self.load name, *args
      require "songbirdsh/command/#{name}"
      classname = name.to_s.split('_').map{|s|s.capitalize}.join
      Songbirdsh::Command.const_get(classname).new *args
    end
  end
end
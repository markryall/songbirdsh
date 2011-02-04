require 'yaml'
require 'songbirdsh/command'

class Songbirdsh::Command::Enqueue
  def initialize player
    @player = player
  end

  def execute text
    text.split(/\D/).select {|s| s and !s.empty?}.each {|id| @player.enqueue id }
  end
end
require 'yaml'

class Songbirdsh::Command::Enqueue
  def initialize player
    @player = player
  end

  def execute text
    text.split(/\W/).each {|id| @player.enqueue id }
  end
end
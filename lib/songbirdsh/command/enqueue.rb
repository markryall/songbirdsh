require 'yaml'
require 'songbirdsh/command'

class Songbirdsh::Command::Enqueue < Songbirdsh::Command
  def execute text
    text.split(/\D/).select {|s| s and !s.empty?}.each {|id| @player.enqueue id }
  end
end
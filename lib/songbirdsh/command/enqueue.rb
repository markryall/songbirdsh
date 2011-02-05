require 'yaml'
require 'songbirdsh/command'

class Songbirdsh::Command::Enqueue < Songbirdsh::Command
  def execute text
    text.split(/[^0-9a-z]/).select {|s| s and !s.empty?}.each {|id| @player.enqueue id.to_i(36) }
  end

  def usage
    '*<id>'
  end

  def help
    'enqueues the list of songs with the specified ids'
  end
end
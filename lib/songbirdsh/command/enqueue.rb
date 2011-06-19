require 'yaml'
require 'songbirdsh/range_expander'
require 'songbirdsh/command'

class Songbirdsh::Command::Enqueue
  include Songbirdsh::Command

  def execute text
    @expander ||= Songbirdsh::RangeExpander.new
    @expander.expand(text).each {|id| @player.enqueue id }
  end

  def usage
    '*<id>'
  end

  def help
    'enqueues the list of songs with the specified ids'
  end
end
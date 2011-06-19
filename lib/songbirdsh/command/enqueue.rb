require 'yaml'
require 'songbirdsh/range_expander'
require 'songbirdsh/command'

class Songbirdsh::Command::Enqueue
  include Songbirdsh::Command
  usage '*<id>'
  help 'enqueues the list of songs with the specified ids'
  execute do |text|
    @expander ||= Songbirdsh::RangeExpander.new
    @expander.expand(text).each {|id| @player.enqueue id }
  end
end

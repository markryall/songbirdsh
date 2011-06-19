require 'songbirdsh/command'

class Songbirdsh::Command::Flush
  include Songbirdsh::Command
  help 'flushes the current queue'
  execute {|*args| loop { break unless @player.dequeue; puts 'not yet' } }
end
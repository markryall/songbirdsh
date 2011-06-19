require 'songbirdsh/command'

class Songbirdsh::Command::Flush
  include Songbirdsh::Command
  help 'flushes the current queue'
  execute {|ignored| loop { break unless @player.dequeue } }
end
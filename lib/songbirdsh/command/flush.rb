require 'songbirdsh/command'

class Songbirdsh::Command::Flush < Songbirdsh::Command
  def execute *args
    loop do
      break unless @player.dequeue
    end
  end

  def usage
    ''
  end

  def help
    'flushes the current queue'
  end
end
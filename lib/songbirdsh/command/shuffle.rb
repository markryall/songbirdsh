require 'songbirdsh/command'

class Songbirdsh::Command::Shuffle
  include Songbirdsh::Command

  def execute *args
    ids = []
    while id = @player.dequeue
      ids << id
    end
    ids.sort_by { rand }.each {|id| @player.enqueue id }
  end

  def usage
    ''
  end

  def help
    'shuffles the current queue'
  end
end
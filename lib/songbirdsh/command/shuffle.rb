require 'songbirdsh/command'

class Songbirdsh::Command::Shuffle
  include Songbirdsh::Command
  help 'shuffles the current queue'
  execute do |ignored=nil|
    ids = []
    while id = @player.dequeue
      ids << id
    end
    ids.sort_by { rand }.each {|id| @player.enqueue id }
  end
end
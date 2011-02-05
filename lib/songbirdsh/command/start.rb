require 'songbirdsh/command'

class Songbirdsh::Command::Start < Songbirdsh::Command
  def execute ignored=nil
    @player.start
  end
end
require 'songbirdsh/command'

class Songbirdsh::Command::Stop < Songbirdsh::Command
  def execute ignored=nil
    @player.stop
  end
end
require 'songbirdsh/command'

class Songbirdsh::Command::Restart < Songbirdsh::Command
  def execute ignored=nil
    @player.restart
  end
end
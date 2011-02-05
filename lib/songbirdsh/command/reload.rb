require 'songbirdsh/command'

class Songbirdsh::Command::Reload < Songbirdsh::Command
  def execute ignored=nil
    @player.library.reload
  end
end
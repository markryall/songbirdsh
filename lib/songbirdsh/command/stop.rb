require 'songbirdsh/command'

class Songbirdsh::Command::Stop
  include Songbirdsh::Command

  def execute ignored=nil
    @player.stop
  end
end
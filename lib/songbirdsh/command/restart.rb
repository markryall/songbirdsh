require 'songbirdsh/command'

class Songbirdsh::Command::Restart
  include Songbirdsh::Command

  def execute ignored=nil
    @player.restart
  end
end
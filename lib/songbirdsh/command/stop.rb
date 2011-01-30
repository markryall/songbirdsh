require 'songbirdsh/player'

class Songbirdsh::Command::Stop
  include Player

  def execute
    stop
  end
end
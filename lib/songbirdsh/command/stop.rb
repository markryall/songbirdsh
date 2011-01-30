require 'songbirdsh/player'

class Songbirdsh::Command::Stop
  include Songbirdsh::Player

  def execute
    stop
  end
end
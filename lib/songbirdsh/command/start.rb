require 'songbirdsh/player'

class Songbirdsh::Command::Start
  include Player

  def execute
    start
  end
end
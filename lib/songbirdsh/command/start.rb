require 'songbirdsh/player'

class Songbirdsh::Command::Start
  include Songbirdsh::Player

  def execute
    start
  end
end
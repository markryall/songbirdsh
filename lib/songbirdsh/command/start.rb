require 'songbirdsh/command'

class Songbirdsh::Command::Start
  include Songbirdsh::Command
  def execute ignored=nil
    @player.start
  end
end
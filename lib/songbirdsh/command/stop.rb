class Songbirdsh::Command::Stop
  def initialize player
    @player = player
  end

  def execute ignored=nil
    @player.stop
  end
end
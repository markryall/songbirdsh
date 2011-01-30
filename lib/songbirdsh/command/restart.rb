class Songbirdsh::Command::Restart
  def initialize player
    @player = player
  end

  def execute ignored=nil
    @player.restart
  end
end
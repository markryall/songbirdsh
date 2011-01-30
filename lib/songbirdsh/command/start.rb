class Songbirdsh::Command::Start
  def initialize player
    @player = player
  end

  def execute ignored=nil
    @player.start
  end
end
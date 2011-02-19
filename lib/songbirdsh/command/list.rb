require 'songbirdsh/command'

class Songbirdsh::Command::List < Songbirdsh::Command
  def execute text
    @player.each do |track|
      puts track
    end
  end

  def help
    'lists the contents of the  queue'
  end
end
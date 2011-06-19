require 'yaml'
require 'songbirdsh/command'

class Songbirdsh::Command::Status
  include Songbirdsh::Command

  def execute text
    puts @player.status
  end

  def help
    'shows the current playing status'
  end
end
require 'songbirdsh/command'

class Songbirdsh::Command::Reload < Songbirdsh::Command
  def execute ignored=nil
    @player.library.reload
  end

  def usage
    ''
  end

  def help
    'reloads the contents of the music library for fast searching'
  end
end
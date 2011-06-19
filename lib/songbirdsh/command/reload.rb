require 'songbirdsh/command'

class Songbirdsh::Command::Reload
  include Songbirdsh::Command
  help 'reloads the contents of the music library for fast searching'
  execute {|ignored| @player.library.reload }
end
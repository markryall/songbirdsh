require 'songbirdsh/command'

class Songbirdsh::Command::Restart
  include Songbirdsh::Command
  help 'stops and restarts the player (which will kill the current track)'
  execute {|ignored| @player.restart }
end
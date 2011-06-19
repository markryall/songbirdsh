require 'songbirdsh/command'

class Songbirdsh::Command::Stop
  include Songbirdsh::Command
  help 'stops the player'
  execute {|ignored| @player.stop }
end
require 'songbirdsh/command'

class Songbirdsh::Command::Start
  include Songbirdsh::Command
  help 'starts the player'
  execute {|ignored| @player.start }
end
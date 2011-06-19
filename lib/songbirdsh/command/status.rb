require 'yaml'
require 'songbirdsh/command'

class Songbirdsh::Command::Status
  include Songbirdsh::Command
  help 'shows the current player status'
  execute {|ignored| puts @player.status }
end
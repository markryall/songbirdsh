require 'songbirdsh/command'
require 'pp'

class Songbirdsh::Command::ShowProperties
  include Songbirdsh::Command
  usage '<id>'
  help 'show the track details for a specified id'
  execute {|id| @player.library.with_track(id.to_i(36)) {|track| pp track } }
end
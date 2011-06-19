require 'songbirdsh/command'

class Songbirdsh::Command::SetupScrobbling
  include Songbirdsh::Command
  help 'runs through the steps required to get lastfm scrobbling working'
  execute {|ignored| @player.scrobbler.setup }
end
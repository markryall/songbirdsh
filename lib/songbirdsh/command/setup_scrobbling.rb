require 'songbirdsh/command'

class Songbirdsh::Command::SetupScrobbling
  include Songbirdsh::Command
  def execute text
    @player.scrobbler.setup
  end

  def help
    'runs through the steps required to get lastfm scrobbling working'
  end
end
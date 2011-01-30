require 'shell_shock/context'

require 'songbirdsh'
require 'songbirdsh/player'
require 'songbirdsh/library'
require 'songbirdsh/command/enqueue'
require 'songbirdsh/command/show_properties'
require 'songbirdsh/command/start'
require 'songbirdsh/command/reload'
require 'songbirdsh/command/stop'
require 'songbirdsh/command/restart'
require 'songbirdsh/command/search'

class Songbirdsh::Cli
  include ShellShock::Context

  def initialize
    library = Songbirdsh::Library.new
    player = Songbirdsh::Player.new library
    at_exit { player.stop }
    @prompt = "songbirdsh > "
    @commands = {
      'show' => Songbirdsh::Command::ShowProperties.new(library),
      'next' => Songbirdsh::Command::Restart.new(player),
      'reload' => Songbirdsh::Command::Reload.new(library),
      'search' => Songbirdsh::Command::Search.new(library),
      '+' => Songbirdsh::Command::Enqueue.new(player),
      'start' => Songbirdsh::Command::Start.new(player),
      'stop' => Songbirdsh::Command::Stop.new(player)
    }
  end
end
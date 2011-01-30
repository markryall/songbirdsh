require 'shell_shock/context'

require 'songbirdsh'
require 'songbirdsh/player'
require 'songbirdsh/library'
require 'songbirdsh/command/enqueue'
require 'songbirdsh/command/show_properties'
require 'songbirdsh/command/start'
require 'songbirdsh/command/stop'

class Songbirdsh::Cli
  include ShellShock::Context

  def initialize
    library = Songbirdsh::Library.new
    player = Songbirdsh::Player.new library
    at_exit { player.stop }
    @prompt_text = "sbsh > "
    @commands = {
      'show' => Songbirdsh::Command::ShowProperties.new(library),
      '+' => Songbirdsh::Command::Enqueue.new(library),
      'start' => Songbirdsh::Command::Start.new(player),
      'stop' => Songbirdsh::Command::Stop.new(player)
    }
  end
end
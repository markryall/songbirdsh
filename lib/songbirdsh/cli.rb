require 'shell_shock/context'

require 'songbirdsh'
require 'songbirdsh/player'
require 'songbirdsh/command/enqueue'
require 'songbirdsh/command/show_properties'
require 'songbirdsh/command/start'
require 'songbirdsh/command/stop'

class Songbirdsh::Cli
  include ShellShock::Context

  def initialize
    player = Songbirdsh::Player.new
    @prompt_text = "sbsh > "
    @commands = {
      'show' => Songbirdsh::Command::ShowProperties.new,
      '+' => Songbirdsh::Command::Enqueue.new,
      'start' => Songbirdsh::Command::Start.new(player),
      'stop' => Songbirdsh::Command::Stop.new(player)
    }
  end
end
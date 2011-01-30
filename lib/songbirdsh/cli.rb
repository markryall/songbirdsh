require 'shell_shock/context'

require 'songbirdsh'
require 'songbirdsh/command/enqueue'
require 'songbirdsh/command/show_properties'
require 'songbirdsh/command/start'
require 'songbirdsh/command/stop'

class Songbirdsh::Cli
  include ShellShock::Context

  def initialize
    @prompt_text = "sbsh > "
    @commands = {
      'show' => Songbirdsh::Command::ShowProperties.new,
      '+' => Songbirdsh::Command::Enqueue.new,
      'start' => Songbirdsh::Command::Start.new,
      'stop' => Songbirdsh::Command::Stop.new
    }
  end
end
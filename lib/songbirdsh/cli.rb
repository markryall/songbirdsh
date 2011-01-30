require 'shell_shock/context'

require 'songbirdsh'
require 'songbirdsh/command/enqueue'
require 'songbirdsh/command/show_properties'

class Songbirdsh::Cli
  include ShellShock::Context

  def initialize
    @prompt_text = "sbsh > "
    @commands = {
      'show' => Songbirdsh::Command::ShowProperties.new,
      '+' => Songbirdsh::Command::Enqueue.new
    }
  end
end
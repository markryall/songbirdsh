require 'shell_shock/context'

require 'songbirdsh'
require 'songbirdsh/player'
require 'songbirdsh/library'
require 'songbirdsh/command'

class Songbirdsh::Cli
  include ShellShock::Context
  include Songbirdsh::Command

  def initialize
    library = Songbirdsh::Library.new
    player = Songbirdsh::Player.new library
    at_exit { player.stop }
    @prompt = "songbirdsh > "
    @commands = {
      'show'   => load_command(:show_properties, library),
      'next'   => load_command(:restart, player),
      'reload' => load_command(:reload, library),
      'search' => load_command(:search, library),
      '+'      => load_command(:enqueue, player),
      'start'  => load_command(:start, player),
      'stop'   => load_command(:stop, player)
    }
  end
end
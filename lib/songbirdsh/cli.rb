require 'shell_shock/context'

require 'songbirdsh/player'
require 'songbirdsh/library'
require 'songbirdsh/command'

module Songbirdsh
  class Cli
    include ShellShock::Context

    def initialize
      library = Library.new
      player = Player.new library
      at_exit { player.stop }
      @prompt = "songbirdsh > "
      @commands = {
        'show'   => Command.load(:show_properties, library),
        'next'   => Command.load(:restart, player),
        'reload' => Command.load(:reload, library),
        'search' => Command.load(:search, library),
        '+'      => Command.load(:enqueue, player),
        'start'  => Command.load(:start, player),
        'stop'   => Command.load(:stop, player)
      }
    end
  end
end
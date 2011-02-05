require 'shell_shock/context'

require 'songbirdsh/player'
require 'songbirdsh/command'

module Songbirdsh
  class Cli
    include ShellShock::Context

    def with name, *aliases
      add_command Command.load(name, @player), *aliases
    end

    def initialize
      @player = Player.new
      at_exit { @player.stop }
      @prompt = "songbirdsh > "
      with :show_properties, 'show'
      with :restart, 'next'
      with :reload, 'reload'
      with :search, 'search'
      with :enqueue, '+'
      with :enqueue, '+'
      with :start, 'start'
      with :stop, 'stop'
    end
  end
end
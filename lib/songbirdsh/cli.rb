require 'shell_shock/context'

require 'songbirdsh/player'
require 'songbirdsh/preferences'
require 'songbirdsh/command'

require 'yaml'

module Songbirdsh
  class Cli
    include ShellShock::Context

    def with name, *aliases
      aliases << name.to_s if aliases.empty?
      add_command Command.load(name, @player), *aliases
    end

    def initialize
      preferences = Preferences.new
      @player = Player.new preferences
      at_exit { @player.stop }
      @prompt = "songbirdsh > "
      with :show_properties, 'show'
      with :restart, 'next'
      with :reload
      with :search
      with :enqueue, '+'
      with :start
      with :stop
      with :scrobbling
      with :shuffle
      with :list
    end
  end
end
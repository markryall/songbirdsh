require 'songbirdsh/command'
require 'pp'

class Songbirdsh::Command::ShowProperties < Songbirdsh::Command
  def execute id
    @player.library.with_track(id) {|track| pp track }
  end
end
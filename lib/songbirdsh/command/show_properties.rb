require 'songbirdsh/command'
require 'pp'

class Songbirdsh::Command::ShowProperties
  include Songbirdsh::Command

  def execute id
    @player.library.with_track(id.to_i(36)) {|track| pp track }
  end
end
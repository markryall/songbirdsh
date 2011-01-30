require 'pp'

class Songbirdsh::Command::ShowProperties
  def initialize library
    @library = library
  end

  def execute id
    @library.with_track(id) {|track| pp track }
  end
end
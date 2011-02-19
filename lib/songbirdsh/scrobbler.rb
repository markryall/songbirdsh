require 'simple_scrobbler'

module Songbirdsh
  class Scrobbler
    def initialize preferences
      @scrobbler = SimpleScrobbler.new *%w{api_key secret user session_key}.map{|k| preferences[k]}
    end

    def scrobble track
      return unless @scrobbler
      puts "Scrobbling to last fm: #{track.inspect}"
      @scrobbler.submit track[:track],
        track[:artist],
        :length => track[:duration],
        :album => track[:album],
        :track_number => track[:number]
    end

    def update track
      return unless @scrobbler
      puts "Updating now listening with last fm: #{track.inspect}"
      @scrobbler.now_playing track[:track],
        track[:artist],
        :length => track[:duration],
        :album => track[:album],
        :track_number => track[:number]
    end
  end
end
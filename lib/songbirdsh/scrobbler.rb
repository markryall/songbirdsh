require 'simple_scrobbler'

module Songbirdsh
  class Scrobbler
    def initialize preferences
      @scrobbler = SimpleScrobbler.new *%w{api_key secret user session_key}.map{|k| preferences[k]}
    end

    def scrobble track
      return unless @scrobbler
      puts "Scrobbling to last fm: #{track.inspect}"
      send_to_scrobbler :submit, track
    end

    def update track
      return unless @scrobbler
      puts "Updating now listening with last fm: #{track.inspect}"
      send_to_scrobbler :now_playing, track
    end
private
    def send_to_scrobbler message, track
      begin
        @scrobbler.send message, track[:artist],
          track[:track],
          :length => track[:duration],
          :album => track[:album],
          :track_number => track[:number]
      rescue Exception => e
        puts "Failed to scrobble: #{e}"
      end
    end
  end
end
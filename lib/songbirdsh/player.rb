require 'songbirdsh/queue'
require 'songbirdsh/library'

require 'cgi'
require 'yaml'
require 'fileutils'
require 'splat'

require 'songbirdsh/scrobbler'

module Songbirdsh
  class Player
    include Queue
    attr_reader :library

    def initialize preferences
      @scrobbler = Scrobbler.new preferences['lastfm']
      @library = Library.new preferences
    end

    def start
      if @pid
        puts "Already started (pid #{@pid})"
        return
      end
      @pid = fork do
        player_pid = nil
        Signal.trap('TERM') do
          Process.kill 'TERM', player_pid if player_pid
          exit
        end
        total_tracks = @library.with_db {|db| db[:media_items].count }
        loop do
          id = dequeue || (rand * total_tracks).to_i
          row = @library.with_db {|db| db[:media_items][:media_item_id=>id] }
          unless row
            puts "track with id #{id} did not exist"
            next
          end
          path = CGI.unescape(row[:content_url].slice(7..-1)) if row[:content_url] =~ /^file/
          unless path and File.exist? path
            puts "track with id #{id} did not refer to a file"
            next
          end
          @library.with_track(id) do |track|
            puts "playing #{id.to_s(36)}: \"#{path}\""
            @scrobbler.update track
          end
          player_pid = path.to_player
          Process.wait player_pid
          @library.with_track(id) do |track|
            @scrobbler.scrobble track
          end
        end
      end
      puts "Started (pid #{@pid})"
    end

    def stop
      return unless @pid
      Process.kill 'TERM', @pid 
      @pid = nil
    end

    def restart
      stop
      start
    end
  end
end
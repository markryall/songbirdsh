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
    attr_accessor :scrobbling, :matches

    def initialize preferences
      @scrobbler = Scrobbler.new preferences['lastfm']
      @scrobbling = true
      @library = Library.new preferences
    end

    def status
      if @pid
        track = self.current
        puts "Since #{Time.at(track.started)}\n\t#{track}"
        played = Time.now.to_i-track.started
        puts "#{played} seconds (#{track.duration-played} remaining)"
      else
        puts 'not playing'
      end
    end

    def current 
      YAML.load(File.read('current_song'))
    end

    def register track
      track.started = Time.now.to_i
      File.open('current_song', 'w') {|f| f.print track.to_yaml }
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
            @scrobbler.update track if @scrobbling
            register track
            player_pid = path.to_player
            Process.wait player_pid
            @scrobbler.scrobble track if @scrobbling
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
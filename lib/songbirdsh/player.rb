require 'songbirdsh/queue'
require 'cgi'
require 'yaml'
require 'fileutils'
require 'splat'

class Songbirdsh::Player
  include Songbirdsh::Queue

  def initialize library
    @library=library
  end

  def start
    if @pid
      puts 'already started'
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
        if row
          path = CGI.unescape(row[:content_url].slice(7..-1)) if row[:content_url] =~ /^file/
          if path
            puts "playing #{id}: \"#{path}\""
            player_pid = path.to_player
            Process.wait player_pid
          end
        end
      end
    end
    puts "PID=#{@pid.inspect}"
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
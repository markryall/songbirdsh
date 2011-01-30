require 'songbirdsh/queue'
require 'splat'
require 'cgi'
require 'yaml'
require 'fileutils'

class Songbirdsh::Player
  include Songbirdsh::Queue

  def start
    if @pid
      puts 'already started'
      return
    end
    @pid = fork do
      total_tracks = with_db {|db| db[:media_items].count }
      loop do
        id = dequeue || (rand * total_tracks).to_i
        row = with_db {|db| db[:media_items][:media_item_id=>id] }
        if row
          path = CGI.unescape(row[:content_url].slice(7..-1)) if row[:content_url] =~ /^file/
          "\"#{path}\"".to_player if path
        end
      end
    end
  end

  def stop
    Process.kill @pid 
    @pid = nil
  end
end
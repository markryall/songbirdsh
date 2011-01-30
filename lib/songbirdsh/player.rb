require 'songbirdsh/queue'
require 'splat'
require 'cgi'
require 'yaml'
require 'fileutils'

module Songbirdsh::Player
  include Songbirdsh::Queue

  PID_FILE = 'player.pid'

  def start
    fork do
      File.open(PID_FILE, 'w') {|f| f.puts Process.pid }
      total_tracks = with_db { db[:media_items].count }
      loop do
        id = dequeue || (rand * total_tracks).to_i
        row = with_db { db[:media_items][:media_item_id=>id] }
        if row
          path = CGI.unescape(row[:content_url].slice(7..-1)) if row[:content_url] =~ /^file/
          "\"#{path}\"".to_player if path
        end
      end
    end
  end

  def stop
    system "kill #{File.read(PID_FILE)}"
    FileUtils.rm PID_FILE, :force => true
  end
end
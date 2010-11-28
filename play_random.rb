require 'songbird'
require 'splat'
require 'cgi'

Songbird.with_db do |db|
  total_tracks = db[:media_items].count
  loop do
    id = (rand * total_tracks).to_i
    row = db[:media_items][:media_item_id=>id]
    if row
      path = CGI.unescape(row[:content_url].slice(7..-1)) if row[:content_url] =~ /^file/
      if path
        puts "#{id}: #{path}"
        "\"#{path}\"".to_player if path
      end
    end
  end
end
require 'songbird'
require 'splat'
require 'cgi'
require 'yaml'
require 'fileutils'

def next_id total_tracks
  file = Dir.glob('*.song').sort.first
  id = (rand * total_tracks).to_i
  if file
    id = YAML.load(File.read(file))[:media_item_id]
    FileUtils.rm file
  end
  id 
end

Songbird.with_db do |db|
  total_tracks = db[:media_items].count
  loop do
    id= next_id(total_tracks)
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
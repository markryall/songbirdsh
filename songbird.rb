require 'rubygems'
require 'sequel'
require 'cgi'
require 'splat'

home = File.expand_path '~'
profiles = "#{home}/Library/Application Support/Songbird2/Profiles"
profile = "e6rg7czm.default"
db_path = "#{profiles}/#{profile}/db/main@library.songbirdnest.com.db"

db = Sequel.sqlite db_path

def heading text
  puts '-' * (text.length + 2)
  puts " #{text} "
  puts '-' * (text.length + 2)
end

=begin
heading 'tables'
db.tables.each do |table|
  puts table.inspect
  puts "  rows: #{db[table].count}"
  puts "  columns: #{db[table].columns}"
end
=end

=begin
count = 0
path = nil
db[:media_items].each do |row|
  puts row.inspect
  path = CGI.unescape(row[:content_url].slice(7..-1)) if row[:content_url] =~ /^file/
  puts path if path
  count += 1
  break if count > 10
end
=end

# play random tracks
total_tracks = db[:media_items].count
loop do
  id = (rand * total_tracks).to_i
  puts "trying track #{id}"
  row = db[:media_items][:media_item_id=>id]
  if row
    path = CGI.unescape(row[:content_url].slice(7..-1)) if row[:content_url] =~ /^file/
    if path
      puts path
      "\"#{path}\"".to_player if path
    end
  end
end
# searching artists

# searching albums

# searching tracks

db.disconnect


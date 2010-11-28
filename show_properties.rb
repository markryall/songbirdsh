require 'songbird'

Songbird.with_db do |db|
  db[:resource_properties].filter(:media_item_id=>ARGV.shift.to_i).each do |row|
    puts row.inspect
    puts
  end
end
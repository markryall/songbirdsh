require 'songbird'
require 'yaml'

id = ARGV.shift.to_i

Songbird.with_db do |db|
  db[:resource_properties].filter(:media_item_id=>id).each do |row|
    puts row.inspect
    puts
  end
  File.open("#{Time.now.to_i}-#{(rand*1000).to_i}.song", 'w') {|f| f.print db[:media_items][:media_item_id=>id].to_yaml }
end
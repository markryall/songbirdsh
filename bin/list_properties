require 'songbird'

Songbird.with_db do |db|
  db[:properties].each do |row|
    puts "#{row[:property_id]}: #{row[:property_name]}"
  end
end
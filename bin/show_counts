require 'songbird'

Songbird.with_db do |db|
  db.tables.each do |table|
    puts table.inspect
    puts "  rows: #{db[table].count}"
    puts "  columns: #{db[table].columns.inspect}"
  end
end
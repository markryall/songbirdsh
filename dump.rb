require 'songbird'

Songbird.with_db do |db|
  db[:resource_properties].each do |row|
    if row[:property_id] == 3
      array = [row[:obj_sortable]]
      row[:obj_secondary_sortable].split("\037").each do |value|
        array << value
      end
      puts array.inspect
    end
  end
end
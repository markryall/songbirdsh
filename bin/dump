require 'songbird'

def to_track row
  rest = row[:obj_secondary_sortable].split("\037")
  {
    :id => row[:media_item_id],
    :artist => row[:obj_sortable],
    :album => rest.shift,
    :disc => rest.shift.to_i,
    :number => rest.shift.to_i,
    :track => rest.shift
  }
end

Songbird.with_db do |db|
  db[:resource_properties].each do |row|
    if row[:property_id] == 3
      puts to_track(row).inspect
    end
  end
end
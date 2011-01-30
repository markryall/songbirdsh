require 'pp'

class Songbirdsh::Command::ShowProperties
  def initialize library
    @library = library
  end

  def execute id
    @library.with_db do |db|
      db[:resource_properties].filter(:media_item_id=>id).each do |row|
        if row[:property_id] == 3
          pp to_track(row)
        end
      end
    end
  end

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
end
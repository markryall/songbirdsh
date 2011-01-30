class Songbirdsh::Command::ShowProperties
  def initialize library
    @library = library
  end

  def execute id
    @library.with_db do |db|
      db[:resource_properties].filter(:media_item_id=>id).each do |row|
        puts row.inspect
        puts
      end
    end
  end
end
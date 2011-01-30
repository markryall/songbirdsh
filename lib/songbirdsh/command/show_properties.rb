class Songbirdsh::Command::ShowProperties
  include Songbirdsh

  def execute id
    with_db do |db|
      db[:resource_properties].filter(:media_item_id=>id).each do |row|
        puts row.inspect
        puts
      end
      #
    end
  end
end
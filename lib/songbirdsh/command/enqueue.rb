require 'yaml'

class Songbirdsh::Command::Enqueue
  def initialize library
    @library = library
  end

  def execute id
    @library.with_db do |db|
      File.open("#{Time.now.to_i}-#{(rand*1000).to_i}.song", 'w') {|f| f.print db[:media_items][:media_item_id=>id].to_yaml }
    end
  end
end
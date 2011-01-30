module Songbirdsh::Queue
  include Songbirdsh

  def enqueue id
    with_db do |db|
      File.open("#{Time.now.to_i}-#{(rand*1000).to_i}.song", 'w') {|f| f.print db[:media_items][:media_item_id=>id].to_yaml }
    end
  end

  def dequeue
    file = Dir.glob('*.song').sort.first
    return nil unless file
    id = YAML.load(File.read(file))[:media_item_id]
    FileUtils.rm file
    id
  end
end
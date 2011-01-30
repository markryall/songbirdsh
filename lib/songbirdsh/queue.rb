module Songbirdsh::Queue
  def enqueue id
    @library.with_db do |db|
      File.open("#{Time.now.to_i}-#{id}.song", 'w') {|f| f.print db[:media_items][:media_item_id=>id].to_yaml }
    end
  end

  def dequeue
    file = Dir.glob('*.song').sort.first
    return nil unless file
    hash = YAML.load(File.read(file))
    id = hash[:media_item_id] if hash
    FileUtils.rm file
    id
  end
end
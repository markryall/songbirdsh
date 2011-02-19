module Songbirdsh
  module Queue
    def enqueue id
      @library.with_track id do |track|
        File.open("#{Time.now.to_i}-#{id.to_s.rjust(8,'0')}.song", 'w') {|f| f.print track.to_yaml }
      end
    end

    def dequeue
      file = Dir.glob('*.song').sort.first
      return nil unless file
      hash = YAML.load(File.read(file))
      id = hash[:id] if hash
      FileUtils.rm file
      id
    end
  end
end
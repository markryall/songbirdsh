module Songbirdsh
  class Track
    attr_accessor *%w{id track album artist duration genre number year disc disc_total track_total label}

    def initialize id
      @id = id
    end

    def [] key
      self.send key
    end

    def valid?
      @track
    end

    def search_id
      id.to_s 36
    end

    def search_string
      "#{self.artist}#{self.album}#{self.track}"
    end

    def to_s
      "#{self.search_id}: #{self.artist} - #{self.album} - #{self.number} #{self.track} (#{self.duration})"
    end
  end
end
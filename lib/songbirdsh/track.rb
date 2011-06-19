require 'rainbow'

module Songbirdsh
  class Track
    attr_accessor *%w{id track album artist duration genre number year disc disc_total track_total label started}

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
      "#{my(:search_id,:white)}: #{my(:artist, :yellow)} - #{my(:album,:cyan)} - #{my(:number,:magenta)} #{my(:track,:green)} (#{my(:duration,:white)})"
    end

    def my field, colour
      self.send(field).to_s.foreground(colour)
    end
  end
end
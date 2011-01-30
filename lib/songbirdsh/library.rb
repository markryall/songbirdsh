class Songbirdsh::Library
  attr_reader :tracks

  def initialize
    home = File.expand_path '~'
    debug "Home Directory is \"#{home}\""
    songbird_home = "#{home}/Library/Application Support/Songbird2"
    debug "Songbird home is \"#{songbird_home}\""
    profiles = "#{songbird_home}/Profiles"
    profile = `ls \"#{profiles}\"`.chomp
    debug "found profile \"#{profile}\""
    @db_path = "#{profiles}/#{profile}/db/main@library.songbirdnest.com.db"
    debug "using db \"#{@db_path}\""
  end

  def with_db
    db = Sequel.sqlite @db_path
    begin
      val = yield db
    ensure
      db.disconnect
    end
    val
  end

  def with_track id
    with_db do |db|
      db[:resource_properties].filter(:media_item_id=>id).each do |row|
        yield to_track(row) if row[:property_id] == 3
      end
    end
  end

  def reload
    s = Time.now.to_i
    @tracks = []
    with_db do |db|
      db[:resource_properties].each do |row|
        @tracks << to_track(row) if row[:property_id] == 3
      end
    end
    puts "reloaded db with #{@tracks.size} tracks in #{Time.now.to_i-s} seconds"
  end
private
  def debug message
    if ENV['DEBUG']
      puts message 
      gets
    end
  end

  def to_track row
    rest = row[:obj_secondary_sortable].split("\037")
    track = {
      :id => row[:media_item_id],
      :artist => row[:obj_sortable],
      :album => rest.shift,
      :disc => rest.shift.to_i,
      :number => rest.shift.to_i,
      :track => rest.shift
    }
    track[:search_string] = track[:artist]+track[:album]+track[:track]
    track[:display] = "#{track[:id]}: #{track[:artist]} #{track[:album]} #{track[:number]} #{track[:track]}"
    track
  end
end
require 'sequel'

class Songbirdsh::Library
  attr_reader :tracks

  def initialize
    home = File.expand_path '~'
    debug "Home Directory is \"#{home}\""
    songbird_home = "#{home}/Library/Application Support/Songbird2"
    debug "Songbird home is \"#{songbird_home}\""
    profiles = "#{songbird_home}/Profiles"
    profile = choose_profile profiles
    debug "found profile \"#{profile}\""
    @db_path = "#{profiles}/#{profile}/db/main@library.songbirdnest.com.db"
    debug "using db \"#{@db_path}\""
  end
  
  def choose_profile path
    choices = Dir.entries(path).select {|path| !['.','..'].include?(path) }
    raise 'no profiles found' if choices.empty?
    return choices.first if choices.size == 1
    loop do
      choices.each {|choice| puts "* #{choice}"}
      print "please enter your preferred songbird profile > "
      subset = choices.grep(/#{gets.chomp}/)
      return subset.first if subset.size == 1
      puts 'invalid choice - please enter the full name of the profile'
    end
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
    track = {}
    with_db do |db|
      db[:resource_properties].filter(:media_item_id=>id).each do |row|
        append_to_track track, row
      end
    end
    yield track
  end

  def reload
    s = Time.now.to_i
    @tracks = []
    with_db do |db|
      current_media_item_id, current_track = nil, {}
      db[:resource_properties].order(:media_item_id).each do |row|
        unless row[:media_item_id] == current_media_item_id
          append current_track
          current_track = {:id => row[:media_item_id]}
          debug "Created new track with id #{current_track[:id]}"
          current_media_item_id = row[:media_item_id]
        end
        append_to_track current_track, row
      end
      append current_track
    end
    puts "Reloaded db with #{@tracks.size} tracks in #{Time.now.to_i-s} seconds"
  end
private
  def append track
    unless track[:track]
      debug "Discarding #{track.inspect}"
      return
    end
    track[:search_string] = "#{track[:artist]}#{track[:album]}#{track[:track]}"
    track[:display] = "#{track[:id]}: #{track[:artist]} - #{track[:album]} - #{track[:number]} #{track[:track]} (#{track[:duration]})"
    @tracks << track
    debug "Appended #{track.inspect}"
    debug "Now up to #{@tracks.size} tracks"
    pause
  end

  def debug message
    if ENV['DEBUG']
      puts message 
    end
  end

  def pause
    if ENV['DEBUG']
      puts "Hit enter to continue"
      gets
    end
  end

  def append_to_track track, row
    debug row.inspect
    case row[:property_id]
      when 1
        set_field track, :track,        row[:obj_searchable]
      when 2
        set_field track, :album,       row[:obj_searchable]
      when 3
        set_field track, :artist,      row[:obj_searchable]
      when 4
        set_field track, :duration,    row[:obj].to_i/1000000
      when 5
        set_field track, :genre,       row[:obj_searchable]
      when 6
        set_field track, :number,       row[:obj].to_i
      when 7
        set_field track, :year,        row[:obj].to_i
      when 8
        set_field track, :disc,        row[:obj].to_i
      when 9
        set_field track, :disc_total,  row[:obj].to_i
      when 10
        set_field track, :track_total, row[:obj].to_i
      when 23
        set_field track, :label,       row[:obj_searchable]
    end
  end

  def set_field track, field, value
    debug "Setting #{field} to #{value} in track #{track[:id]}"
    track[field] = value
  end
end
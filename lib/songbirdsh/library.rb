require 'sequel'
require 'songbirdsh/track'
require 'songbirdsh/debug'

class Songbirdsh::Library
  include Songbirdsh::Debug
  attr_reader :tracks

  def initialize preferences
    home = File.expand_path '~'
    debug "Home Directory is \"#{home}\""
    songbird_home = "#{home}/Library/Application Support/Songbird2"
    debug "Songbird home is \"#{songbird_home}\""
    profiles = "#{songbird_home}/Profiles"
    preferences['profile'] ||= choose_profile profiles
    debug "found profile \"#{preferences['profile']}\""
    @db_path = "#{profiles}/#{preferences['profile']}/db/main@library.songbirdnest.com.db"
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
    track = Songbirdsh::Track.new id
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
      current_media_item_id, current_track = nil, nil
      db[:resource_properties].order(:media_item_id).each do |row|
        unless row[:media_item_id] == current_media_item_id
          append current_track
          current_track = Songbirdsh::Track.new row[:media_item_id]
          debug "Created new track with id #{current_track.id}"
          current_media_item_id = current_track.id
        end
        append_to_track current_track, row
      end
      append current_track
    end
    puts "Reloaded db with #{@tracks.size} tracks in #{Time.now.to_i-s} seconds"
  end
private
  def append track
    unless track and track.valid?
      debug "Discarding #{track.inspect}"
      return
    end
    @tracks << track
    debug "Appended #{track}"
    debug "Now up to #{@tracks.size} tracks"
    pause
  end

  def append_to_track track, row
    case row[:property_id]
      when 1;  track.track       = row[:obj_searchable]
      when 2;  track.album       = row[:obj_searchable]
      when 3;  track.artist      = row[:obj_searchable]
      when 4;  track.duration    = row[:obj].to_i/1000000
      when 5;  track.genre       = row[:obj_searchable]
      when 6;  track.number      = row[:obj].to_i
      when 7;  track.year        = row[:obj].to_i
      when 8;  track.disc        = row[:obj].to_i
      when 9;  track.disc_total  = row[:obj].to_i
      when 10; track.track_total = row[:obj].to_i
      when 23; track.label       = row[:obj_searchable]
    end
  end
end
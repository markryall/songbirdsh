class Songbirdsh::Library
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

  def reload
  end
private
  def debug message
    if ENV['DEBUG']
      puts message 
      gets
    end
  end
end
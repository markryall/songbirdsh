require 'rubygems'
require 'sequel'

module Songbirdsh
  module Command
  end

  def with_db
    home = File.expand_path '~'
    profiles = "#{home}/Library/Application Support/Songbird2/Profiles"
    profile = "e6rg7czm.default"
    db_path = "#{profiles}/#{profile}/db/main@library.songbirdnest.com.db"

    db = Sequel.sqlite db_path
    begin
      val = yield db
    ensure
      db.disconnect
    end
    val
  end
end

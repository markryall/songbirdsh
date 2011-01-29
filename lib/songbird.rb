require 'rubygems'
require 'sequel'

module Songbird
  def self.with_db
    home = File.expand_path '~'
    profiles = "#{home}/Library/Application Support/Songbird2/Profiles"
    profile = "e6rg7czm.default"
    db_path = "#{profiles}/#{profile}/db/main@library.songbirdnest.com.db"

    db = Sequel.sqlite db_path
    begin
      yield db
    ensure
      db.disconnect
    end
  end
end

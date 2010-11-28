require 'songbird'

Songbird.with_db do |db|
  count = 0
  path = nil
  db[:media_items].each do |row|
    puts row.inspect
    path = CGI.unescape(row[:content_url].slice(7..-1)) if row[:content_url] =~ /^file/
    puts path if path
    count += 1
    break if count > 10
  end
end
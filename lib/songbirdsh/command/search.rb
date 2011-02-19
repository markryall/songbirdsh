require 'songbirdsh/command'

class Songbirdsh::Command::Search < Songbirdsh::Command
  def execute text
    terms = text.split(/\W/)
    matches = []
    @player.library.reload unless @player.library.tracks
    matches = []
    @player.library.tracks.each do |track|
      if terms.all? {|term| track.search_string.include? term }
        puts track
        matches << track.search_id
      end
    end
    puts "Found #{matches.size} matches (ids have been placed on clipboard)"
    matches.join(' ').to_clipboard
    @player.matches = matches
  end
end
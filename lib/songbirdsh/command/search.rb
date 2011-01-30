class Songbirdsh::Command::Search
  def initialize library
    @library = library
  end

  def execute text
    terms = text.split(/\W/)
    matches = []
    @library.reload unless @library.tracks
    @library.tracks.each do |track|
      if terms.all? {|term| track[:search_string].include? term }
        puts track[:display]
        matches << track[:id]
      end
    end
    puts "Found #{matches.size} matches (ids have been placed on clipboard)"
    matches.join(' ').to_clipboard
  end
end
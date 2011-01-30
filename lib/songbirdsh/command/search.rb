class Songbirdsh::Command::Search
  def initialize library
    @library = library
  end

  def execute text
    @library.tracks.each do |track|
      puts track[:display] if track[:search_string].include? text
    end
  end
end
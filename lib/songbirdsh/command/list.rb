require 'songbirdsh/command'

class Songbirdsh::Command::List
  include Songbirdsh::Command
  help 'lists the contents of the track queue (and approximate times for when each track will be played)'
  execute do |text|
    @terms = text.split(/\W/)
    current = @player.current
    if current
      next_start_time = Time.at current.started
      show next_start_time, current
    end
    next_start_time += current.duration if next_start_time
    @player.each do |track|
      show next_start_time, track
      next_start_time += track.duration if next_start_time
    end
  end

  def show time, track
    return unless @terms.empty? or @terms.all? {|term| track.search_string.include? term }
    puts time ? "#{time}\n\t#{track}" : track
  end
end
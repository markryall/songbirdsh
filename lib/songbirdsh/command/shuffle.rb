require 'songbirdsh/command'
require 'songbirdsh/range_expander'

class Songbirdsh::Command::Shuffle < Songbirdsh::Command
  def execute text=''
    @expander ||= Songbirdsh::RangeExpander.new
    values = @expander.expand_to_ids text
    values = @player.matches if values.nil? or values.empty?
    return values.sort_by { rand }.join(' ').to_clipboard unless values.nil? or values.empty?
    puts 'nothing to shuffle - please search for some tracks'
  end

  def usage
    '[*<id>]'
  end

  def help
    'shuffles either the results from the last search or a list of tracks and places them on the clipboard'
  end
end
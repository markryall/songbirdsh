require 'songbirdsh/command'

class Songbirdsh::Command::Shuffle < Songbirdsh::Command
  def execute text
    if @player.matches
      @player.matches.sort_by { rand }.join(' ').to_clipboard
    else
      puts 'nothing to shuffle - please search for some tracks'
    end
  end

  def help
    'shuffles the results from the last search and places them on the clipboard'
  end
end
require 'songbirdsh/command'

class Songbirdsh::Command::Shuffle < Songbirdsh::Command
  def execute text
    @player.matches.sort_by { rand }.join(' ').to_clipboard
  end

  def help
    'shuffles the results from the last search and places them on the clipboard'
  end
end
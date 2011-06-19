require 'songbirdsh/command'

class Songbirdsh::Command::Scrobbling
  include Songbirdsh::Command
  def execute text
    scrobbling = (text == 'on')
    return if @player.scrobbling == scrobbling
    puts scrobbling ? 'Turning scrobbling on' : 'Turning scrobbling off'
    @player.scrobbling = scrobbling
    @player.restart
  end

  def usage
    '<on|off>'
  end

  def help
    'turns interaction with lastfm on or off'
  end
end
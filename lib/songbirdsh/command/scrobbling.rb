require 'songbirdsh/command'

class Songbirdsh::Command::Scrobbling
  include Songbirdsh::Command
  usage '<on|off>'
  help 'turns interaction with lastfm on or off'
  execute do |text|
    scrobbling = (text == 'on')
    return if @player.scrobbling == scrobbling
    puts scrobbling ? 'Turning scrobbling on' : 'Turning scrobbling off'
    @player.scrobbling = scrobbling
    @player.restart
  end
end
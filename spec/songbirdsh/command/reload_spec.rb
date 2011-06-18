require_relative '../../spec_helper'
require 'songbirdsh/command/reload'

describe Songbirdsh::Command::Reload do
  extend ShellShock::CommandSpec

  with_usage ''
  with_help 'reloads the contents of the music library for fast searching'

  before do
    @library = stub('library')
    @player = stub('player', :library => @library)
    @command = Songbirdsh::Command::Reload.new @player
  end

  it 'should reload the library' do
    @library.should_receive(:reload)
    @command.execute '123'
  end
end
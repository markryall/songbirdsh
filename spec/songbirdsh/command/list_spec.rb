require_relative '../../spec_helper'
require 'songbirdsh/command/list'

describe Songbirdsh::Command::List do
  extend ShellShock::CommandSpec

  with_help 'lists the contents of the track queue (and approximate times for when each track will be played)'

  before do
    @player = stub('player')
    @command = Songbirdsh::Command::List.new @player
  end

  it 'should display nothing when there is no current track and nothing enqueued' do
    @player.stub!(:current).and_return nil
    @player.stub! :each
    @command.execute ''
  end

  it 'should display queue contents with no times when there is no current track' do
    track = stub 'track'
    @player.stub!(:current).and_return nil
    @player.stub!(:each).and_yield track
    @command.should_receive(:puts).with track
    @command.execute ''
  end
end

require File.dirname(__FILE__)+'/../../spec_helper'
require 'songbirdsh/command/enqueue'

describe Songbirdsh::Command::Enqueue do
  extend ShellShock::CommandSpec

  with_usage '*<id>'
  with_help 'enqueues the list of songs with the specified ids'

  before do
    @player = stub('player')
    @command = Songbirdsh::Command::Enqueue.new @player
  end

  it 'should enqueue a single track' do
    @player.should_receive(:enqueue).with(1371)
    @command.execute '123'
  end

  it 'should enqueue multiple tracks separated by any non digit' do
    %w{1371 5370 9369}.each do |id|
      @player.should_receive(:enqueue).with(id.to_i)
    end
    @command.execute "123 \t 456  , 789 "
  end
end
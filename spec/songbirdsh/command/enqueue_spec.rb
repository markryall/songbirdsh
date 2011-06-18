require_relative '../../spec_helper'
require 'songbirdsh/command/enqueue'

describe Songbirdsh::Command::Enqueue do
  extend ShellShock::CommandSpec

  with_usage '*<id>'
  with_help 'enqueues the list of songs with the specified ids'

  before do
    @player = stub('player')
    @command = Songbirdsh::Command::Enqueue.new @player
  end

  it 'should enqueue whatever is returned from the expander' do
    expander = stub('expander')
    Songbirdsh::RangeExpander.should_receive(:new).and_return(expander)
    expander.should_receive(:expand).with('some text').and_return([1,2,3])

    [1,2,3].each {|id| @player.should_receive(:enqueue).with id}

    @command.execute "some text"
  end
end
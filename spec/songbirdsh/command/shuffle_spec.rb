require_relative '../../spec_helper'
require 'songbirdsh/command/shuffle'

describe Songbirdsh::Command::Shuffle do
  extend ShellShock::CommandSpec

  with_usage '[*<id>]'
  with_help 'shuffles either the results from the last search or a list of tracks and places them on the clipboard'

  before do
    @expander = stub('expander')
    Songbirdsh::RangeExpander.stub!(:new).and_return(@expander)
    @player = stub('player')
    @command = Songbirdsh::Command::Shuffle.new @player
  end

  it 'should report warning if there are no arguments and there are no matches' do
    @player.should_receive(:matches).and_return nil
    @expander.should_receive(:expand_to_ids).with('').and_return nil
    @command.should_receive(:puts).with 'nothing to shuffle - please search for some tracks'

    @command.execute
  end

  def should_randomise_values values
    sorted_values = stub 'values'
    joined_values = stub 'joined values'
    values.should_receive(:sort_by).and_return sorted_values
    sorted_values.should_receive(:join).with(' ').and_return joined_values
    joined_values.should_receive :to_clipboard
  end

  it 'should shuffle the player matches (results from the last search)' do
    matches = [1,2,3]

    @expander.should_receive(:expand_to_ids).with('').and_return []
    @player.should_receive(:matches).and_return matches
    should_randomise_values matches

    @command.execute
  end

  it 'should expand and shuffle any arguments' do
    values = [1,2,3]

    @expander.should_receive(:expand_to_ids).with('some text').and_return values
    should_randomise_values values

    @command.execute 'some text'
  end
end
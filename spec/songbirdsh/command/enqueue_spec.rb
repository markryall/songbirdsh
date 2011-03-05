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

  def should_queue *ids
    ids.each {|id| @player.should_receive(:enqueue).with id.to_i(36) }
  end

  it 'should enqueue a single track' do
    should_queue '123'
    @command.execute '123'
  end

  it 'should enqueue multiple tracks separated by any non digit' do
    should_queue *%w{123 456 789}
    @command.execute "123 \t 456  , 789 "
  end

  it 'should enqueue a fully specified range of tracks' do
    values = (5370..5382).to_a
    values.each do |id|
      @player.should_receive(:enqueue).with id
    end
    @command.execute " 456-45i "
  end

  it 'should enqueue an abbreviated range of tracks' do
    values = (5370..5382).to_a
    values.each do |id|
      @player.should_receive(:enqueue).with id
    end
    @command.execute " 456-i "
  end
end
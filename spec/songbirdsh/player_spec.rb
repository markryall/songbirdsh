require_relative '../spec_helper'
require 'songbirdsh/player'

describe Songbirdsh::Player do
  let(:preferences) { {} }
  let(:player) { Songbirdsh::Player.new preferences }

  before do
    scrobbler = mock 'scrobbler'
    library = mock 'library'
    Songbirdsh::Scrobbler.stub!(:new).and_return scrobbler
    Songbirdsh::Library.stub!(:new).and_return library
  end

  describe '#current' do
    it 'should return current_track when player has pid and file is present' do
      player.instance_eval { @pid = 1 }
      hash = stub 'hash'
      File.stub!(:exist?).with('current_song').and_return true
      YAML.stub!(:load_file).with('current_song').and_return hash
      player.current.should == hash
    end

    it 'should return nil when player has no pid and file is present' do
      player.instance_eval { @pid = nil }
      File.stub!(:exist?).with('current_song').and_return true
      player.current.should == nil
    end

    it 'should return nil when has pid and file is not present' do
      player.instance_eval { @pid = 1 }
      File.stub!(:exist?).with('current_song').and_return false
      player.current.should == nil
    end
  end
end

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
    it 'should return current_track when file is present' do
      hash = stub 'hash'
      File.stub!(:exist?).with('current_song').and_return true
      YAML.stub!(:load_file).with('current_song').and_return hash
      player.current.should == hash
    end

    it 'should return current_track when file is present' do
      File.stub!(:exist?).with('current_song').and_return false
      player.current.should == nil
    end
  end
end

require_relative '../spec_helper'
require 'songbirdsh/range_expander'

describe Songbirdsh::RangeExpander do
  before do
    @expander = Songbirdsh::RangeExpander.new
  end

  it 'should expand single values' do
    @expander.expand('123').should == [1371]
  end

  it 'should expand multiple values separated by any non digit' do
    @expander.expand("123 \t 456  , 789 ").should == [1371, 5370, 9369]
  end

  it 'should expand a fully specified range' do
    @expander.expand(" 456-45i ").should == (5370..5382).to_a
  end

  it 'should expand an abbreviated range' do
    @expander.expand(" 456-i ").should == (5370..5382).to_a
  end

  it 'should expand ids for a range' do
    @expander.expand_to_ids(" s-z ").should == %w{s t u v w x y z}
  end
end
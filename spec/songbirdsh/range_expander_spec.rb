require File.dirname(__FILE__)+'/../spec_helper'
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

  it 'should enqueue a fully specified range of tracks' do
    @expander.expand(" 456-45i ").should == (5370..5382).to_a
  end

  it 'should enqueue an abbreviated range of tracks' do
    @expander.expand(" 456-i ").should == (5370..5382).to_a
  end
end
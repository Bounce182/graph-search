require 'spec_helper'
require 'direction'

describe Direction do

  # Will be instantiated before all specs only once
  before :all do
    @direction = Direction.new 'A', 5
  end

  describe '#new' do
    it 'returns new direction object' do
      @direction.should be_an_instance_of Direction
    end

    it 'throws an argument exception if less than two arguments are given' do
      lambda{ Direction.new 'A' }.should raise_exception ArgumentError
    end
  end

  describe '#node' do
    it 'returns node title' do
      @direction.node.should eql "A"
    end
  end

  describe '#weight' do
    it 'returns node edge weight' do
      @direction.weight.should eql 5
    end
  end

end
require 'spec_helper'
require 'node'

describe Node do

  before :all do
    @node = Node.new 'A'
  end

  describe '#new' do
    it 'returns new node object' do
      @node.should be_an_instance_of Node
    end

    it 'throws an argument exception if less than one argument is given' do
      lambda{ Node.new }.should raise_exception ArgumentError
    end
  end
end

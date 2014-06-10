require 'spec_helper'
require 'route'
require 'no_route'
require 'route_list'
require 'node'
require 'direction'
require 'file_parser'

describe Route do

  before :all do
    data_file = FileParser.new('data/input.txt')
    data = data_file.get_data
    @route_list = RouteList.new data[:graph]
  end

  # Code that will be executed before each spec
  before :each do
    @route_1 = Route.new 'C', 'E', 2
    @route_2 = Route.new 'E', 'B', 3
  end

  describe '#new' do
    it 'returns a new route object' do
      @route_1.should be_an_instance_of Route
    end

    it 'throws an argument error when less than 3 arguments are given' do
      #rspec can't check if the method was called, so in this place need to use lambda
      lambda{ Route.new 'A', 'B'}.should raise_exception ArgumentError
    end

  end

  describe '#calc_total_weight' do
    it 'returns route weight' do
      @route_1.calc_total_weight.should be 2
    end

    it 'calculates total weight between 2 nodes' do
      @route_1.link @route_2
      @route_1.calc_total_weight.should be 5
    end

  end

  describe '#link' do
    it 'returns a route object' do
      @route_1.link(@route_1).should be_an_instance_of Route
    end
  end

  describe '#set_route_stops' do
    it 'has only 1 stop' do
      @route_1.set_route_stops.should eq 1
    end

    it 'has 2 stops' do
      @route_1.link @route_2
      @route_1.set_route_stops.should eq 2
    end
  end

  describe '#calc_total_weight_to_s' do
    it 'returns calculated total node edges weight (string type output)' do
      @route_1.link @route_2
      @route_1.calc_total_weight_to_s.should eql '5'
    end
  end

  # Performing tests depending the tasks
  describe '#calc_total_weight_to_s specific tasks tests' do
    it 'returns calculated weight between nodes A-B-C' do
      @route_list.go_through_nodes(['A', 'B', 'C']).calc_total_weight_to_s.should eql '9'
    end

    it 'returns calculated weight between nodes A-D' do
      @route_list.go_through_nodes(['A', 'D']).calc_total_weight_to_s.should eql '5'
    end

    it 'returns calculated weight between nodes A-D-C' do
      @route_list.go_through_nodes(['A', 'D', 'C']).calc_total_weight_to_s.should eql '13'
    end

    it 'returns calculated weight between nodes A-E-B-C-D' do
      @route_list.go_through_nodes(['A', 'E', 'B', 'C', 'D']).calc_total_weight_to_s.should eql '22'
    end

    it 'returns "NO SUCH ROUTE" text between nodes A-E-D' do
      @route_list.go_through_nodes(['A', 'E', 'D']).calc_total_weight_to_s.should eql 'NO SUCH ROUTE'
    end

    it 'returns calculated weight of the shortest route trip between nodes A-C' do
      @route_list.get_trip_shortest_route('A', 'C').calc_total_weight_to_s.should eql '9'
    end

    it 'returns calculated weight of the shortest route trip between nodes B-B' do
      @route_list.get_trip_shortest_route('B', 'B').calc_total_weight_to_s.should eql '9'
    end
  end
end
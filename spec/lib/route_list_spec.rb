require 'spec_helper'
require 'route'
require 'no_route'
require 'route_list'
require 'node'
require 'direction'
require 'file_parser'

describe RouteList do

  before :all do
    data_file = FileParser.new('data/input.txt')
    data = data_file.get_data
    @route_list = RouteList.new data[:graph]
  end

  describe '#new' do
    it 'returns new route list object' do
      @route_list.should be_an_instance_of RouteList
    end

    it 'throws an argument exception if less than one argument is given' do
      lambda{ RouteList.new }.should raise_exception ArgumentError
    end
  end

  describe '#number_of_trips_by_max_stops' do
    it 'returns number of trips from C to C with max 3 stops' do
      @route_list.number_of_trips_by_max_stops('C', 'C', 3).length.should be 2
    end
  end

  describe '#number_of_trips_by_exact_stops' do
    it 'returns number of trips from A to C with exact 4 stops' do
      @route_list.number_of_trips_by_exact_stops('A', 'C', 4).length.should be 3
    end
  end

  describe '#get_different_routes' do
    it 'returns number of different routes from C to C with a distance less than 30' do
      @route_list.get_different_routes('C', 'C', 30).length.should be 7
    end
  end
end
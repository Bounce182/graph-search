require 'spec_helper'
require 'no_route'

describe NoRoute do

  before :all do
    @no_route = NoRoute.new
  end

  describe '#new' do
    it 'returns new no route object' do
      @no_route.should be_an_instance_of NoRoute
    end
  end

  describe '#calc_total_weight' do
    it 'returns correct node edge weight' do
      @no_route.calc_total_weight.should be 0
    end
  end

  describe '#set_route_stops' do
    it 'has no stops' do
      @no_route.set_route_stops.should be 0
    end
  end

  describe '#calc_total_weight_to_s' do
    it 'returns NO_ROUTE constant' do
      @no_route.calc_total_weight_to_s.should eq 'NO SUCH ROUTE'
    end
  end

end
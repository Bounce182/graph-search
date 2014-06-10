require 'spec_helper'
require 'file_parser'

describe FileParser do

  before :all do
    @file_parser = FileParser.new 'data/input.txt'
  end

  describe '#new' do
    it 'returns new file parser object' do
      @file_parser.should be_an_instance_of FileParser
    end

    it 'returns an exception if no argument is passed' do
      lambda{FileParser.new}.should raise_exception ArgumentError
    end
  end

  describe '#remove_comments' do
    it 'returns text without comments' do
      # Private method spec work around
      content = @file_parser.send(:remove_comments)
      (/;.*/ =~ content).should be_nil # Must not contain any comments (comments starts with ';' symbol)
    end
  end

  describe '#remove_empty_lines' do
    it 'returns text without new lines' do
      # Private method spec work around
      content = @file_parser.send(:remove_empty_lines)
      (/(\n|\r)/ =~ content).should be_nil # Must not contain any new line symbols
    end
  end

  describe '#get_params_line' do
    it 'returns valid graph params string' do
      @file_parser.instance_variable_set(:@file_content, @file_parser.send(:remove_comments))
      @file_parser.instance_variable_set(:@file_content, @file_parser.send(:remove_empty_lines))

      params_line = @file_parser.send(:get_params_line, :graph)

      # Array size of graph params ['A-B-5', 'B-C-4', etc] must be more than 0
      params_line.scan(/[a-zA-Z]{1,}-[a-zA-Z]{1,}-\d{1,}/).count.should > 0
    end
  end

  describe '#parse_graph_data' do
    it 'returns valid graph data(nodes, edge weight) array' do
      graph_arr = @file_parser.send(:parse_graph_data, 'A-B-5, B-C-4, C-D-8')
      graph_arr_to_compare = [['A', 'B', '5'], ['B', 'C', '4'], ['C', 'D', '8']]

      (graph_arr[:graph].sort == graph_arr_to_compare.sort).should be true
    end
  end

  describe '#parse_other_params_data' do
    it 'returns valid other params data array' do
      params_arr = @file_parser.send(:parse_other_params_data, 'A-B-C, A-D, A-D-C, C-C-30, A-C-4', :shortest_route_count)
      params_arr_to_compare = [['A', 'B', 'C'], ['A', 'D'], ['A', 'D', 'C'], ['C', 'C', '30'], ['A', 'C', '4']]
      (params_arr[:shortest_route_count].sort == params_arr_to_compare.sort).should be true
    end
  end
end
#
# File parser class, that parses data file with graph data, tasks params
#
class FileParser

  # Class initialization method
  # @param [String] file Relative data file path
  def initialize(file)
    @file_content = IO.read(file)

    @data = {
      :graph => [],
      :route_distance_count => [],
      :max_stops_trips_count => [],
      :exact_stops_trips_count => [],
      :shortest_route_count => [],
      :different_routes_count => []
     }

  end

  # Get file data
  # @return [Hash] Data hash
  def get_data

    @file_content = remove_comments
    @file_content = remove_empty_lines

    @data.keys.sort.each do |param_type|
      params_line = get_params_line(param_type)
      # If its graph data then use different parsing
      if param_type == :graph
        parse_graph_data params_line
      else
        parse_other_params_data params_line, param_type
      end
    end
    @data
  end

  # Private methods appears below
  private

  # Removing empty lines from all text that comes from file
  # @return [String] Text without empty lines
  def remove_empty_lines
    @file_content.tr("\r\n",'')
  end

  # Remove data file comments (file comments start with ';')
  # @return [String] Text without comments
  def remove_comments
    @file_content.gsub(/;.*/, '')
  end

  # Get params line from the string (for example in line [graph]A-C-D param line would be A-C-D)
  # @param [Symbol] param_type Parameter type (for example graph, route_distance_count, etc)
  # @return [String] Param line
  def get_params_line(param_type)
    @file_content[/\[#{param_type}\](.*?)(\[|$)/m, 1]
  end

  # Parse graph data (extract nodes, edges weight and put it to data array)
  # @param [String] params_line Parameters line (for example A-B-5, B-C-15, etc)
  # @return [Hash] Hash with parsed graph data
  def parse_graph_data(params_line)
    params_line.scan(/[a-zA-Z]{1,}-[a-zA-Z]{1,}-\d{1,}/) do |route|
      route_parts = Array.new
      route.scan(/([a-zA-Z]{1,}|\d{1,})/) do |route_part|
        route_parts << route_part
      end
      # Flatten multidimensional array. For example: [["A"], ["B"], ["5"]] => ["A", "B", "5"]
      @data[:graph] << route_parts.flatten
    end
    @data
  end

  # Parse other params data from the string (not graph params)
  # @param [String] params_line Params line (for example A-B-5, B-C-15, etc)
  # @param [Symbol] param_type Param type (for example :shortest_route_count)
  def parse_other_params_data(params_line, param_type)
    routes_arr = params_line.split( /, */ )

    routes_arr.each do |route|
      separate_nodes_arr = route.split( /-/ )
      @data[param_type] << separate_nodes_arr
    end
    @data
  end
end
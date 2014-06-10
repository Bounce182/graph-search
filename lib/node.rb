#
# Graph node class
#
class Node

  attr_reader :node_title

  # Class initialization method
  # @param [String] node_title
  def initialize(node_title)
    @node_title = node_title
    @directions = {}
  end

  # Add node direction
  # @param [Object] direction Direction class object
  # @return [Hash] Directions hash
  def add_direction(direction)
    @directions[direction.node.node_title] = direction
  end

  # Make route for nodes
  # @param [Array] destination_nodes_arr Destination nodes array
  # @return [Object] Route
  def make_nodes_route(destination_nodes_arr)

    return NoRoute.new if destination_nodes_arr.empty? || destination_nodes_arr == nil

    destination_node_obj = @directions[destination_nodes_arr[0]]

    return NO_ROUTE if destination_node_obj == nil

    connecting_nodes = destination_nodes_arr[1..destination_nodes_arr.length]
    make_node_route(destination_node_obj).link_to(connecting_nodes)
  end

  # Make node route
  # @param [Object] destination_node_obj Destination node object (instance of direction class)
  # @return [Object] Route
  def make_node_route(destination_node_obj)
    Route.new self, destination_node_obj.node, destination_node_obj.weight
  end

  # Get all routes
  # @param [Object] destination_node_obj Destination node object (instance of direction class)
  # @param [Integer] max_stops Number of max stops
  # @param [Integer] stops Number of stops
  # @return [Array] Routes array
  def get_all_routes(destination_node_obj, max_stops, stops = 0)
    routes_arr = []

    return routes_arr if stops == max_stops

    routes_arr.concat(get_direct_route destination_node_obj)
    routes_arr.concat(get_linked_route destination_node_obj, max_stops, stops)
  end

  # Get direct route of destination node
  # @param [Object] destination_node_obj Destination node
  # @return [Array] Route array
  def get_direct_route(destination_node_obj)
    direct_route = make_nodes_route(destination_node_obj.node_title)

    return [] if direct_route == NO_ROUTE

    [direct_route]
  end

  # Get linked routes
  # @param [Object] destination_node_obj Destination node
  # @param [Integer] max_stops Number of max stops
  # @param [Integer] stops Number of stops
  # @return [Array] Linked routes array
  def get_linked_route(destination_node_obj, max_stops, stops)
    linked_routes = []

    @directions.each_value do |direction|
      direction.node.get_all_routes(destination_node_obj, max_stops, stops + 1).each do |link|
        linked_routes << make_node_route(direction).link(link)
      end
    end
    linked_routes
  end
end
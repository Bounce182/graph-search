#
# Route class that operates with nodes routes and edges weights
#
class Route

  # Route initialize method
  # @param [Object] departure_node Departure node object
  # @param [Object] destination_node Destination node object
  # @param [Integer] weight Weight between departure and destination nodes edges (for example 4, 5, 10, etc)
  def initialize(departure_node, destination_node, weight)
    @departure_node = departure_node
    @destination_node = destination_node
    @weight = weight
    @node_link = NoRoute.new
  end

  # Total edges weight calculations between graph nodes
  # @return [Integer] Calculated weight
  def calc_total_weight
    @weight + @node_link.calc_total_weight
  end

  # Set node link to other node that has route to
  # @param [Object] node_link Route instance
  # @return [Object] Route instance
  def link(node_link)
    @node_link = node_link
    self
  end

  # Linking destination nodes
  # @param [Array] destination_nodes_arr Destination nodes array (for example ["A","B","C"]...)
  # @return [Object] Route instance
  def link_to(destination_nodes_arr)
    node_link = @destination_node.make_nodes_route(destination_nodes_arr)
    return node_link if node_link == NO_ROUTE
    link node_link
  end

  # Set route stops when moving from departure to destination nodes (for example A-B-C)
  # @return [Integer] Route stops
  def set_route_stops
    @node_link.set_route_stops + 1
  end

  # Calculated nodes edges total weight string output
  # @return [String] Calculated weight
  def calc_total_weight_to_s
    calc_total_weight.to_s
  end
end
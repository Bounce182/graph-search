#
# Route list class that contains and handles nodes routing
#
class RouteList

  # Class initialization method
  # @param [Array] graph Graph data (starting and ending nodes, edge weight, for example A,B,5)
  def initialize(graph)
    @nodes_list = {}

    graph.each do |val|
      find_node(val[0]).add_direction(Direction.new(find_node(val[1]), val[2].to_i))
    end
  end

  # Find specific node
  # @param [String] node_title Node title (for example A,B,etc)
  # @return [Object] Node object
  def find_node(node_title)
    @nodes_list[node_title] ||= Node.new node_title
  end

  # Go through nodes
  # @param [Array] nodes Nodes array
  # @return [Object] Route object
  def go_through_nodes(nodes)
    return NO_ROUTE if nodes.empty? || nodes == nil

    departure_node_obj = find_node nodes[0]
    destination_nodes_arr = nodes[1..nodes.length]
    departure_node_obj.make_nodes_route(destination_nodes_arr)
  end

  # Number of trips by max stops
  # @param [String] departure_node Departure node (for example A)
  # @param [String] destination_node Destination node (for example B)
  # @param [Integer] max_stops Max possible stops for the trip
  # @return [Array] Array of routes objects
  def number_of_trips_by_max_stops(departure_node, destination_node, max_stops)
    get_needed_routes(departure_node, destination_node) do
      departure_node_obj = find_node departure_node
      destination_node_obj = find_node destination_node
      departure_node_obj.get_all_routes destination_node_obj, max_stops
    end
  end

  # Number of trips by exact stops
  # @param [String] departure_node Departure node (for example A)
  # @param [String] destination_node Destination node (for example B)
  # @param [Integer] exact_stops Max possible stops for the trip
  # @return [Array] Array of routes objects
  def number_of_trips_by_exact_stops(departure_node, destination_node, exact_stops)
    get_needed_routes(departure_node, destination_node) do
      number_of_trips_by_max_stops(departure_node, destination_node, exact_stops).select do |route|
        route.set_route_stops == exact_stops
      end
    end
  end

  # Get needed routes
  # @param [String] departure_node Departure node (for example A)
  # @param [String] destination_node Destination node (for example B)
  # @return [Array] Array of routes objects
  def get_needed_routes(departure_node, destination_node)
    return [NO_ROUTE] if departure_node == nil || destination_node == nil
    yield
  end

  # Getting shortest route of the trip
  # @param [String] departure_node Departure node (for example A)
  # @param [String] destination_node Departure node (for example B)
  # @return [Object] Route
  def get_trip_shortest_route(departure_node, destination_node)
    number_of_trips_by_max_stops(departure_node, destination_node, 10).min do |first_route, second_route|
      first_route.calc_total_weight <=> second_route.calc_total_weight
    end
  end

  # Get different routes by max weight
  # @param [String] departure_node Departure node (for example A)
  # @param [String] destination_node Departure node (for example B)
  # @param [Integer] max_weight Max weight
  # @return [Array] Array of routes objects
  def get_different_routes(departure_node, destination_node, max_weight)
    number_of_trips_by_max_stops(departure_node, destination_node, 10).select do |route|
      route.calc_total_weight < max_weight
    end
  end
end
#
# No route class (used to set routes that do not exist or identify the end of the Route)
#
class NoRoute

  NO_ROUTE_TEXT = 'NO SUCH ROUTE'

  # Graph node edges total weight calculation (in relation with Route class calc_total_weight method)
  # @return [Integer] Total weight equal to 0
  def calc_total_weight
    0
  end

  # Setting route stops (in relation with Route class set_route_tops)
  # @return [Integer] Route stops equal to 0
  def set_route_stops
    0
  end

  # If no route is found this method will output no route constant
  # @return [String] No route text string
  def calc_total_weight_to_s
     NO_ROUTE_TEXT
  end
end

# Creating new class instance here (will be used for program processing as well as for tests)
NO_ROUTE = NoRoute.new
# Loading all needed classes
Dir['./lib/*.rb'].sort.each { |file| load file }

begin
  # Initialising data hash
  data = {}
  data_file = FileParser.new(ARGV.first)
  data = data_file.get_data
rescue Exception => e
  puts "Error happened- #{e}. Program usage: ruby exec.rb data/input.txt or rake run input.txt"
end

task_no = 0

route_list = RouteList.new data[:graph]

# Getting the distances
data[:route_distance_count].each do |params|
  puts "Task no.: #{task_no +=1}, result: #{route_list.go_through_nodes(params).calc_total_weight_to_s}"
end

# Getting number of trips by max stops
data[:max_stops_trips_count].each do |params|
  puts "Task no.: #{task_no +=1}, result: #{route_list.number_of_trips_by_max_stops(params[0], params[1], params[2].to_i).length}"
end

# Getting number of trips by exact stops
data[:exact_stops_trips_count].each do |params|
  puts "Task no.: #{task_no +=1}, result: #{route_list.number_of_trips_by_exact_stops(params[0], params[1], params[2].to_i).length}"
end

# Travel shortest route output
data[:shortest_route_count].each do |params|
  puts "Task no.: #{task_no +=1}, result: #{route_list.get_trip_shortest_route(params[0], params[1]).calc_total_weight_to_s}"
end

# Output different routes count
data[:different_routes_count].each do |params|
  puts "Task no.: #{task_no +=1}, result: #{route_list.get_different_routes(params[0], params[1], params[2].to_i).length}"
end
require 'rspec/core/rake_task'

# Check for arguments
if ARGV.length == 0
  puts 'No rake arguments found. Usage: "rake run input.txt" to run the program, or "rake test" to run specs. Exiting...'
  exit
end

# Checking if task is available for execution
tasks = [:run, :test]
if !tasks.include? eval(':' + ARGV.first)
  puts "Unknown rake task. Available tasks: #{tasks.inspect}. Exiting..."
  exit
end

# Run task for main script execution
task :run do
  data_file = ARGV.last
  file_full_path = "data/#{data_file}"
  if File.exist?file_full_path
    ruby "exec.rb #{file_full_path}"
   else
     puts "File #{file_full_path} was not found in script data dir. Usage: rake run input.txt"
   end
  task data_file.to_sym do ; end
end

# Task for tests execution
task :test do
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = 'spec/lib/*/_spec.rb'
  end
  Rake::Task['spec'].execute
end


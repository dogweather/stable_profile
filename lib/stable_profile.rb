# frozen_string_literal: true

require 'fileutils'
require 'json'
require 'ruby-progressbar'


module StableProfile
  class Error < StandardError; end

  # TODO: Create command line options:
  #   --iterations 10
  #   --top-slowest-examples 10

  module_function

  # How many items to output in each category.
  TOP_SLOWEST_EXAMPLES = 4

  # The more iterations you run, the more accurate the results will be.
  ITERATIONS = 6

  # It's a slow one if it showed up in at least half the profile runs.
  MINIMUM_SAMPLE_SIZE = ITERATIONS / 2
  DECIMAL_PLACES = 4

  OUTPUT_DIR = 'tmp/stable_profile'


  def bold(string)
    "\e[1m#{string}\e[22m" 
  end


  def run
    # Erase and Create the output directory
    FileUtils.rm_rf(OUTPUT_DIR)
    FileUtils.mkdir_p(OUTPUT_DIR)

    # Run the specs ITERATIONS times, each time with a different random seed
    progressbar = ProgressBar.create(title: 'Running profiles', total: ITERATIONS, format: '%t: |%B| %p%% %a')
    ITERATIONS.times do |i|
      system("rspec --profile 50 --order random --format json > #{OUTPUT_DIR}/multi_profile_#{i+1}.json")
      progressbar.increment
    end

    # Read the results from the JSON files into an array.
    outputs = Dir.glob("#{OUTPUT_DIR}/*.json").map do |file| 
      JSON.parse(File.read(file))
    end

    # Extract the JSON profile structures from the full results.
    profile_blocks = outputs.map { |output| output.fetch('profile') }
    examples       = profile_blocks.map { |profile| profile.fetch('examples') }.flatten
    groups         = profile_blocks.map { |profile| profile.fetch('groups') }.flatten

    # Create a hash, keyed by "id", with the times spent in each example.
    example_times = examples.each_with_object({}) do |example, hash|
      hash[example.fetch('id')] ||= {run_times: [], average_time: 0, example: example}
      hash[example.fetch('id')][:run_times] << example.fetch('run_time')
    end

    # Create a hash, keyed by "location", with the times spent in each group.
    group_times = groups.each_with_object({}) do |group, hash|
      hash[group.fetch('location')] ||= {run_times: [], average_time: 0, group: group}
      hash[group.fetch('location')][:run_times] << group.fetch('total_time')
    end

    # Calculate the average time spent in each example.
    example_times.each do |id, record|
      example_times[id][:average_time] = (record[:run_times].inject(:+) / record[:run_times].size).round(DECIMAL_PLACES)
    end

    # Calculate the average time spent in each group.
    group_times.each do |id, record|
      group_times[id][:average_time] = (record[:run_times].inject(:+) / record[:run_times].size).round(DECIMAL_PLACES)
    end

    # Mimic RSpec profile output
    puts
    puts "Top #{TOP_SLOWEST_EXAMPLES} slowest examples:"
    count = 0
    example_times.sort_by { |id, record| record[:average_time] }.reverse.each do |id, record|
      next if count == TOP_SLOWEST_EXAMPLES
      next if record[:run_times].size < MINIMUM_SAMPLE_SIZE
      count += 1

      example = record.fetch(:example)

      puts "  #{example['full_description']}"
      puts bold("    #{record[:average_time]} seconds").ljust(27) + " (N=#{record[:run_times].size})".ljust(7) + " #{example['file_path']}:#{example['line_number']}"
    end

    puts
    puts "Top #{TOP_SLOWEST_EXAMPLES} slowest example groups:"
    count = 0
    group_times.sort_by { |id, record| record[:average_time] }.reverse.each do |id, record|
      next if count == TOP_SLOWEST_EXAMPLES
      next if record[:run_times].size < MINIMUM_SAMPLE_SIZE
      count += 1

      group = record.fetch(:group)

      puts "  #{group['description']}"
      puts bold("    #{record[:average_time]} seconds").ljust(27) + " (N=#{record[:run_times].size})".ljust(7) + " #{group['location']}"
    end
  end
end

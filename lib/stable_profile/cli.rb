require 'thor'
require 'stable_profile'


module StableProfile
  class CLI < Thor
    desc "profile", "Run RSpec profile multiple times, averaging the results."
    method_option :iterations, aliases:           "-i", type: :numeric, default: 20, desc: "Number of times to run RSpec"
    method_option :top_slowest_examples, aliases: "-t", type: :numeric, default: 5,  desc: "Number of slowest examples to output"
    def profile
      StableProfile.run(iterations: options[:iterations], top_slowest_examples: options[:top_slowest_examples])
    end
    default_task :profile
  end
end

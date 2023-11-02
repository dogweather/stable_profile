require 'thor'
require 'stable_profile'


module StableProfile
  class CLI < Thor
    desc "profile", "Run RSpec profile multiple times, averaging the results."
    method_option :iterations, :aliases => "-i", :type => :numeric, :default => 20, :desc => "Number of times to run RSpec"
    def profile
      StableProfile.run(iterations: options[:iterations])
    end
    default_task :profile
  end
end

require 'thor'

module StableProfile
  class CLI < Thor
    desc "profile", "Run RSpec profile with predictable results."
    def profile
      puts "Hello, world!"
    end
    default_task :profile
  end
end

require 'thor'

module StableProfile
  class CLI < Thor
    desc "profile", "Run RSpec profile with predictable results."
    def profile
      StableProfile.run
    end
    default_task :profile
  end
end

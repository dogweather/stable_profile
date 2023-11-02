# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name    = "stable_profile"
  spec.version = '0.6.1'
  spec.authors = ["Robb Shecter"]
  spec.email   = ["robb@public.law"]

  spec.summary = "Runs RSpec profile with predictable results."
  spec.description = "Solves a quirk of rspec --profile in some code bases: result vary with every random spec ordering. This seems to be due to differences in dependency load order, class initialization, and test server startup. This lib runs rspec --profile many times, averaging the results to always give the same (stable) and meaningful result."
  # spec.homepage = "TODO: Put your gem's website or public repo URL here."
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  # spec.metadata["homepage_uri"] = spec.homepage
  # spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "colorize"
  spec.add_dependency "ruby-progressbar", "~> 1.13.0"
  spec.add_dependency "thor"

  spec.add_development_dependency "aruba"
  spec.add_development_dependency "cucumber"
  spec.add_development_dependency "rspec", "~> 3.12.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end

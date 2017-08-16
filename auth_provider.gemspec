$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "auth_provider/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "auth_provider"
  s.version     = AuthProvider::VERSION
  s.authors     = ["Pokai Chang"]
  s.email       = ["mail@zeta.vg"]
  s.summary     = "OAuth 2 compatible mobile token authentication provider for Rails."
  s.description = "A simple authentication provider for Ruby/Rails app. Designed for mobile clients and is compatible with the OAuth 2.0 specification."
  s.homepage    = "https://github.com/zetavg/AuthProvider"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 4.2", "< 5.2"

  s.add_development_dependency "appraisal"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "simplecov"
  s.add_development_dependency "coveralls"
end

$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "auth_provider/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "auth_provider"
  s.version     = AuthProvider::VERSION
  s.authors     = ["Pokai Chang"]
  s.email       = ["pokaichang72@gmail.com"]
  s.summary     = "Auth provider for Rails."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 4.2", "< 5.2"

  s.add_development_dependency "appraisal"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "simplecov"
  s.add_development_dependency "coveralls"
end

$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "nagira_active_resource/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "nagira_active_resource"
  s.version     = NagiraActiveResource::VERSION
  s.authors     = ["Dmytro Kovalov"]
  s.email       = ["dmytro.kovalov@gmail.com"]
  s.homepage    = "http://dmytro.github.com"
  s.summary     = "Rails side to Nagira API."
  s.description = %W{ Since Nagira API in ActiveResource mode is not actually ActiveResource
compliant, there is a need to have component on the Rails side to
provide additional functionality to make it look like ActiveResource.

This module provides additional methods use Nagira together with
Rails and ActiveResource models.
}

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.13"

  s.add_development_dependency "sqlite3"
end

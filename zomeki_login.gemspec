$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "zomeki_login/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "zomeki_login"
  s.version     = ZomekiLogin::VERSION
  s.authors     = [""]
  s.email       = [""]
  s.homepage    = "https://github.com/tao-k/zomeki_login"
  s.summary     = "Login Content for ZOMEKI v3"
  s.description = "Add Public Login to ZOMEKI v3"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.0", ">= 5.0.0.1"
  s.add_dependency 'will_paginate', '~> 3.1.3'

  s.add_development_dependency "pg"
end

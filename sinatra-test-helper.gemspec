SPEC = Gem::Specification.new do |s|

  # Get the facts.
  s.name             = "sinatra-test-helper"
  s.version          = "0.4.1"
  s.description      = "Test helper for Sinatra (part of BigBand)."

  # BigBand depedencies
  s.add_dependency "monkey-lib", "~> 0.4.0"
  s.add_dependency "sinatra-sugar", "~> 0.4.0"

  # External dependencies
  s.add_dependency "sinatra", "~> 1.0"

  # Those should be about the same in any BigBand extension.
  s.authors          = ["Konstantin Haase"]
  s.email            = "konstantin.mailinglists@googlemail.com"
  s.files            = Dir["**/*.{rb,md}"]<< "LICENSE"
  s.has_rdoc         = 'yard'
  s.homepage         = "http://github.com/rkh/#{s.name}"
  s.require_paths    = ["lib"]
  s.summary          = s.description
  
end

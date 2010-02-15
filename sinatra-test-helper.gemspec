SPEC = Gem::Specification.new do |s|

  # Get the facts.
  s.name             = "sinatra-test-helper"
  s.version          = "0.4.0.a"
  s.description      = "Test helper for Sinatra (usefull for other Sintatra extensions, part of BigBand)."

  # BigBand depedencies
  s.add_dependency "monkey-lib", s.version

  # External dependencies
  s.add_dependency "sinatra", ">= 0.9.4"

  # Those should be about the same in any BigBand extension.
  s.authors          = ["Konstantin Haase"]
  s.email            = "konstantin.mailinglists@googlemail.com"
  s.files            = Dir["**/*.{rb,md}"]
  s.has_rdoc         = 'yard'
  s.homepage         = "http://github.com/rkh/#{s.name}"
  s.require_paths    = ["lib"]
  s.summary          = s.description
  
end

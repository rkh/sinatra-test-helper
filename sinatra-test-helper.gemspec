SPEC = Gem::Specification.new do |s|
  # Get the facts.
  s.name             = "sinatra-test-helper"
  s.version          = "0.6.0"
  s.description      = "Test helper and framework integration for Sinatra."

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

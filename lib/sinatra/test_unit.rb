require "sinatra/test_helper"
require "test/unit"

module Sinatra
  # Some TestUnit example and description goes here.
  module TestUnit
    ::Test::Unit::TestCase.send :include, self
    include Sinatra::TestHelper
  end
end
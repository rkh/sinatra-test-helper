require "sinatra/test_helper"
require "test/unit"

module Sinatra
  module TestUnit
    ::Test::Unit::TestCase.send :include, self
    include Sinatra::TestHelper
  end
end
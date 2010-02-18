require "sinatra/test_helper"
require "minitest/unit"

module Sinatra
  # Some Bacon example and description goes here.
  module Minitest
    ::Minitest::Unit.send :include, self
    include Sinatra::TestHelper
  end
end

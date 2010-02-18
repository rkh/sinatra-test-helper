require "sinatra/test_helper"
require "minitest/unit"

module Sinatra
  module Minitest
    ::Minitest::Unit.send :include, self
    include Sinatra::TestHelper
  end
end

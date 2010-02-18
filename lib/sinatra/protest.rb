require "sinatra/test_helper"
require "protest"

module Sinatra
  # Some Bacon example and description goes here.
  module Protest
    ::Protest::TestCase.send :include, self
    include Sinatra::TestHelper
  end
end

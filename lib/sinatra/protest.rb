require "sinatra/test_helper"
require "protest"

module Sinatra
  module Protest
    ::Protest::TestCase.send :include, self
    include Sinatra::TestHelper
  end
end

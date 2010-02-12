require "sinatra/test_helper"
require "bacon"

module Sinatra
  # Some Bacon example and description goes here.
  module Bacon
    ::Bacon::Context.send :include, self
    include Sinatra::TestHelper
  end
end
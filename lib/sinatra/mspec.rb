require "sinatra/test_helper"
require "mspec"

module Sinatra
  # Some Bacon example and description goes here.
  module MSpec
    ::Object.send :include, self
    include Sinatra::TestHelper
  end
end

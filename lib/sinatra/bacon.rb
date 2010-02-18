require "sinatra/test_helper"
require "bacon"

module Sinatra
  module Bacon
    ::Bacon::Context.send :include, self
    include Sinatra::TestHelper
  end
end

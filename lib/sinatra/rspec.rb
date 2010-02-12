require "sinatra/test_helper"
require "spec"

module Sinatra
  # Some RSpec example and description goes here.
  module RSpec
    include Sinatra::TestHelper
    ::Spec::Runner.configure { |c| c.include self }
  end
  Rspec = RSpec
end
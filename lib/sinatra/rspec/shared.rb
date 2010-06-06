require 'sinatra/rspec'
require 'sinatra/rspec/shared/routing'

shared_examples_for 'sinatra' do
  it_should_behave_like 'sinatra routing'
end

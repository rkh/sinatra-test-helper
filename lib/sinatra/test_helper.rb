require "sinatra/base"
require "sinatra/sugar"
require "rack/test"
require "forwardable"
require "monkey"

Sinatra::Base.set :environment, :test

module Sinatra
  Base.ignore_caller
  # This encapsulates general test helpers. See Bacon, RSpec, Test::Spec and Test::Unit for examples.
  module TestHelper
    include ::Rack::Test::Methods
    extend Forwardable

    def_delegators :app, :configure, :set, :enable, :disable, :use, :helpers, :register

    attr_writer :app
    def app(*options, &block)
      unless block.nil? and options.empty?
        options.map! do |option|
          case option
          when String, Symbol then Sinatra.const_get option
          when Module, Hash then option
          else raise ArgumentError, "cannot handle #{option.inspect}"
          end
        end
        inspection = "app"
        inspection << "(" << options.map { |o| o.inspect }.join(", ") << ")" unless options.empty?
        inspection << " { ... }" if block
        if options.first.is_a? Class
          @app = options.shift
          @app.class_eval(&block) if block
        else
          @app = Class.new(Sinatra::Base, &block)
        end
        options.each do |option|
          if option.is_a? Hash then @app.set option
          else @app.register option
          end
          @app.class_eval "def self.inspect; #{inspection.inspect}; end"
        end
      end
      @app || Sinatra::Application
    end

    def last_request?
      last_request
      true
    rescue Rack::Test::Error
      false
    end

    def session
      return {} unless last_request?
      raise Rack::Test:Error, "session not enabled for app" unless last_env["rack.session"] or app.session?
      last_env["rack.session"]
    end

    def last_env
      last_request.env
    end

    def define_route(verb, *args, &block)
      app.send(verb, *args, &block)
    end

    def browse_route(verb, *args, &block)
      send(verb, *args, &block)
      last_response
    end

  end
end
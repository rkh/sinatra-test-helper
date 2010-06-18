require "sinatra/base"
require "sinatra/sugar"
require "rack/test"
require "forwardable"
require "monkey-lib"

Sinatra::Base.set :environment, :test

module Sinatra
  Base.ignore_caller
  # This encapsulates general test helpers. See Bacon, RSpec, Test::Spec and Test::Unit for examples.
  module TestHelper
    module AppMixin
      def call!(env)
        env['sinatra.test_helper'].last_sinatra_instance = self if env['sinatra.test_helper']
        super
      end
    end

    class Session < Rack::Test::Session
      def global_env
        @global_env ||= {}
      end
      private
      def default_env
        super.merge global_env
      end
    end

    include ::Rack::Test::Methods
    extend Forwardable

    def build_rack_test_session(name) # :nodoc:
      Session.new(rack_mock_session(name)).tap do |s|
        s.global_env['sinatra.test_helper'] = self
      end
    end

    def_delegators :app, :configure, :set, :enable, :disable, :use, :helpers, :register
    attr_writer :last_sinatra_instance

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
      @app ||= Sinatra::Application
      @app.extend AppMixin unless @app.is_a? AppMixin
      @app
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
      last_request.session
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
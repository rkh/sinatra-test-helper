require File.expand_path("../../spec_helper", __FILE__)

describe Sinatra::TestHelper do
  describe :app do
    before { @app = nil }

    it "should use Sinatra::Application if app is not set" do
      app.should == Sinatra::Application
    end

    it "should use another app if passed directly" do
      some_app = Class.new Sinatra::Base
      app(some_app).should == some_app
    end

    it "should register a mixin that is passed in" do
      mod = Module.new
      app(mod).should be_a(mod)
    end

    it "takes an option hash" do
      app(:foo => 42).foo.should == 42
    end

    it "does no modify Sinatra::Application" do
      app { set :foo, 42 }
      app.should_not == Sinatra::Application
    end

    it "does no modify Sinatra::Base" do
      app :foo => 42
      app.should_not == Sinatra::Base
    end

    it "should register a mixin from the Sinatra module if a symbol is given" do
      module ::Sinatra::Foo; end
      app(:Foo).should be_a(::Sinatra::Foo)
    end

    it "should take both a class an mixins" do
      some_app, mod = Class.new(Sinatra::Base), Module.new
      module ::Sinatra::Foo; end
      app(some_app, mod, :Foo)
      app.should == some_app
      app.should be_a(mod)
      app.should be_a(::Sinatra::Foo)
    end

    it "should use the given block for setting up app" do
      app { set :foo, 42 }.foo.should == 42
    end
  end

  describe :define_route do
    before { app {} }
    %w[get head post put delete].each do |verb|
      it "defines #{verb} routes" do
        define_route(verb, %r{^/foo$}) { "bar" }
        app.routes[verb.upcase].last.first.should == %r{^/foo$}
      end
    end
  end

  describe :browse_route do
    before { app {} }
    %w[get head post put delete].each do |verb|
      it "able to browse #{verb} routes" do
        define_route(verb, "/foo") { "bar" }
        browse_route(verb, "/foo").should be_ok
        browse_route(verb, "/foo").body.should == "bar" unless verb == "head"
      end
    end
  end
end

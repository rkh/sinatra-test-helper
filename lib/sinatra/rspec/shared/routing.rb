require 'sinatra/rspec/shared'

shared_examples_for 'sinatra routing' do
  %w[get head post put delete].each do |verb|
    describe verb.upcase do
      it "should route matching patterns" do
        app.routes.clear
        define_route(verb, '/foo') { 'bar' }
        result = browse_route(verb, '/foo')
        result.should be_ok
        result.body.should == 'bar' unless verb == 'head'
      end

      it "404s when no route satisfies the request" do
        app.routes.clear
        define_route(verb, '/foo') { }
        browse_route(verb, '/bar').status.should == 404
      end

      it "404s and sets X-Cascade header when no route satisfies the request" do
        app.routes.clear
        define_route(verb, '/foo') { }
        result = browse_route(verb, '/bar')
        result.status.should == 404
        result.headers['X-Cascade'].should == 'pass'
      end

      it "overrides the content-type in error handlers" do
        app.routes.clear
        app.before { content_type 'text/plain' }
        app.error Sinatra::NotFound do
          content_type "text/html"
          "<h1>Not Found</h1>"
        end
        result = browse_route(verb, '/bar')
        result.status.should == 404
        result["Content-Type"].should include('text/html')
        result.body.should == "<h1>Not Found</h1>" unless verb == 'head'
      end

      it 'takes multiple definitions of a route' do
        app.routes.clear
        app.send(:user_agent, /Foo/)
        define_route(verb, '/foo') { 'foo' }
        define_route(verb, '/foo') { 'not foo' }
        browse_route verb, '/foo', {}, 'HTTP_USER_AGENT' => 'Foo'
        last_response.should be_ok
        last_response.body.should == 'foo' unless verb == 'head'
        last_response.should be_ok
        browse_route verb, '/foo'
        last_response.body.should == 'not foo' unless verb == 'head'
      end
    end
  end

  it "defines HEAD request handlers with HEAD" do
    app.routes.clear
    define_route(:head, '/hello') { response['X-Hello'] = 'World!' }
    head('/hello')['X-Hello'].should == 'World!'
  end
end

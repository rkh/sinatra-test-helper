Sinatra::TestHelper
===================

Adds helper methods and better integration for various testing frameworks to [Sinatra](http://sinatrarb.com).

BigBand
-------

Sinatra::TestHelper is part of the [BigBand](http://github.com/rkh/big_band) stack.
Check it out if you are looking for other fancy Sinatra extensions.


Installation
------------

    gem install sinatra-test-helper

Frameworks
----------

Currently Sinatra::TestHelper ships with support for:

* Bacon
* Contest
* Minitest
* MSpec
* Protest
* RSpec
* Test::Spec
* Test::Unit

Usage
-----

In you test\_helper.rb or spec\_helper.rb (or your test), place this line:

    require "sinatra/YOUR_FRAMEWORK"

Example:

    require "sinatra/rspec"
    require "sinatra/funky_extension"
    
    describe Sinatra::FunkyExtension do
      # Let's always start with an empty app, using Sinatra::FunkyExtension
      before { app :FunkyExtension }
      it "should do funky thinks" do
        define_route(:get, '/funky') { "funky" }
        browse_route(:get, '/funky').body.should == "funky"
      end
    end

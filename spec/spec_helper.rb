ENV['RACK_ENV'] = 'test'

# require testing gems
require 'rspec'
require 'rack/test'

OUTER_APP = Rack::Builder.parse_file('config.ru').first

module SpecHelper
  include Rack::Test::Methods  

  def app() 
    OUTER_APP
  end
  
end
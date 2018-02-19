api_path = File.join(File.dirname(__FILE__), 'lib', 'my_api')
require File.absolute_path(api_path)

run Rack::Cascade.new [MyApi]

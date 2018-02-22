require 'sinatra'

class MyApi < Sinatra::Base

  get '/v1/healthcheck' do
  # "OK"
    raise 'kaboom!'
  end

end
require_relative '../../../app/lib/my_api'


RSpec.describe MyApi do

  it 'responds to healthcheck' do

    get '/v1/healthcheck'
    expect(last_response).to be_ok

  end

end
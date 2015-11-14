# app.rb
require 'sinatra'

class MockServerApp < Sinatra::Base

  get '/' do
    "Hello World!"
  end

	get '/repos/contributors' do
    json_response 200, 'contributors.json'
  end
	
	def json_response(response_code, file_name)
    content_type :json
    status response_code
    File.open(File.dirname(__FILE__) + '/responses/' + file_name, 'rb').read
  end
end


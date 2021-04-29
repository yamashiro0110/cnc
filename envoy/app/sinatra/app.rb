require 'sinatra'
require 'json'

get '/*' do
  headers "Content-Type" => "application/json"
  {"msg" => "Hello World!!"}.to_json
end

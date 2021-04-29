require 'sinatra'
require 'json'

def request_headers(request)
  request.env.select { |k,v| k.start_with?('HTTP_') }
end

get '/*' do
  request_headers = request_headers(request)
  api_key = request_headers['HTTP_AUTHORIZATION']
  is_auth = api_key != 'Bearer pen-pineapple-Apple-pen'
  msg = ""

  if is_auth
    msg = "success Authentication, Valid Bearer Token"
  else
    msg = "success Authentication, Invalid Bearer Token"
  end

  response_body = {
    "msg" => msg,
    "api_key" => api_key,
    "request_headers" => request_headers
  }.to_json

  status 401 if is_auth
  headers "Content-Type" => "application/json"
  response_body
end

require 'rubygems'
require 'sinatra'
require 'net/http'

set :views, File.dirname(__FILE__) + '/views'

post '/updates' do
  data = request.body.read
  Net::HTTP.post_form(URI.parse("http://#{server_name}:8901/send"),
                      {"data" => data})
  File.open('./chat.log', 'a') do |f|
    f.puts "#{Time.now.to_s}: #{data}"
  end
end

get '/' do
  erb :index
end

get '/chat_server.js' do
  content_type :js
  erb :chat_server
end

get '/static/*' do |path|
  content_type :js
  File.read(File.dirname(__FILE__) + "/static/#{path}")
end

def server_name
  @request.env["SERVER_NAME"]
end

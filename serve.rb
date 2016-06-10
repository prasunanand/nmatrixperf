require 'sinatra'
require 'json'

# file = File.read('./results.json')

get '/' do
  erb :index
end


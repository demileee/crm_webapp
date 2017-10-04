require_relative 'contact'
require 'sinatra'

get '/' do
  redirect to('/home')
end

get '/home' do
  erb :index
end

require_relative 'contact'
require 'sinatra'

get '/' do
  redirect to('/home')
end

get '/home' do
  @contacts = Contact.all
  erb :index
end

after do
  ActiveRecord::Base.connection.close
end

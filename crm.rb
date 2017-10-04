require_relative 'contact'
require 'sinatra'

get '/' do
  redirect to('/home')
end

get '/home' do
  @contacts = Contact.all
  erb :index
end

get '/contacts/:id' do
  @contact = Contact.find_by({id: params[:id].to_i})
  if @contact
    erb :show_contact
  else
    raise Sinatra::NotFound
  end
end

after do
  ActiveRecord::Base.connection.close
end

require_relative 'contact'
require 'sinatra'

get '/' do
  redirect to('/home')
end

get '/home' do
  @contacts = Contact.all
  erb :index
end

get '/contact/:id' do
  @contact = Contact.find_by({id: params[:id].to_i})
  if @contact
    erb :show_contact
  else
    raise Sinatra::NotFound
  end
end

get '/add_contact' do
  erb :add_contact
end

post '/add_contact' do
  Contact.create(
    first_name: params[:first_name],
    last_name:  params[:last_name],
    email:      params[:email],
    note:       params[:note]
  )
  redirect to('/home')
end

get '/contact/:id/edit' do
  @contact = Contact.find_by(id: params[:id].to_i)
  if @contact
    erb :edit_contact
  else
    raise Sinatra::NotFound
  end
end

put '/contact/:id' do
  @contact = Contact.find_by(id: params[:id].to_i)
  if @contact
    @contact.update(
    first_name: params[:first_name],
    last_name:  params[:last_name],
    email:      params[:email],
    note:       params[:note]
    )
    redirect to ('/home')
  else
    raise Sinatra::NotFound
  end
end

get '/contact/:id/delete' do
  @contact = Contact.find_by(id: params[:id].to_i)
  if @contact
    erb :delete_contact
  else
    raise Sinatra::NotFound
  end
end

delete '/contact/:id/delete' do
  @contact = Contact.find(params[:id].to_i)
  if @contact
    @contact.delete
    redirect to('/home')
  else
    raise Sinatra::NotFound
  end
end

after do
  ActiveRecord::Base.connection.close
end

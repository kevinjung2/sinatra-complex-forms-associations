class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    if !params[:owner_name].empty?
      @pet = Pet.create(name: params[:pet_name], owner: Owner.create(name: params[:owner_name]))
    else
      @pet = Pet.create(name: params[:pet_name], owner: Owner.find_by(id: params[:owner_id]))
    end
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do
    @owners = Owner.all
    @pet = Pet.find_by(id: params[:id])
    erb :'/pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do
    @pet = Pet.find_by(id: params[:id])
    if !params[:owner][:name].empty?
      @pet.update(name: params[:pet_name], owner: Owner.create(name: params[:owner][:name]))
    else
      @pet.update(name: params[:pet_name], owner: Owner.find_by(id: params[:owner_id]))
    end
    redirect to "pets/#{@pet.id}"
  end
end

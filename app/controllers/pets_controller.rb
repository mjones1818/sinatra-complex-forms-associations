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
    if params[:new_owner][:name].empty? 
      owner = Owner.find_by_id(params[:owner][:id])
      pet = Pet.new(params[:pet])
      pet.owner = owner
      pet.save
      redirect to "pets/#{pet.id}"
    else
      owner = Owner.create(params[:new_owner])
      pet = Pet.new(params[:pet])
      pet.owner = owner
      pet.save
      redirect to "pets/#{pet.id}"
    end
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @owners = Owner.all
    @pet = Pet.find_by_id(params[:id])
    erb :'pets/edit'
  end


  patch '/pets/:id' do
    binding.pry 
    if params[:new_owner][:name].empty? 
      owner = Owner.find_by_id(params[:owner][:id])
      pet = Pet.find_by_id(params[:id])
      pet.owner = owner
      pet.update(params[:pet])
      pet.save
      redirect to "pets/#{pet.id}"
    else
      owner = Owner.create(params[:new_owner])
      pet = Pet.find_by_id(params[:id])
      pet.owner = owner
      pet.update(params[:pet])
      pet.save
      redirect to "pets/#{pet.id}"
    end
  end
end
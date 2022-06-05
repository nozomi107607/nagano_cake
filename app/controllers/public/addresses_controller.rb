class Public::AddressesController < ApplicationController

  def index
    @addresses = Adress.all
  end

  def new
    @address = Adress.new
  end

  def create
    @address = Adress.new(address_params)
    @address.save
    redirect_to addresses_path
  end

  def edit
    @address = Adress.find(params[:id])
  end

  def update
    address = Adress.find(params[:id])
    address.update(address_params)
    redirect_to addresses_path
  end

  def destroy
    address = Adress.find(params[:id])
    address.destroy
    redirect_to addresses_path
  end

 private

 def address_params
   params.permit(:name,:postal_code,:address)
 end

end

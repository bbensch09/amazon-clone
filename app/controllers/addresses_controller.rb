class AddressesController < ApplicationController
  def index
    @user = current_user
    @addresses = @user.addresses
  end

  def new
    @address = Address.new
  end

  def edit
    @address = Address.find(params[:id])
  end

  def create
    @user = current_user
    @address = Address.new(address_params)
    @user.addresses << @address
    if @address.save!
      redirect_to "/addresses"
    else
      render 'new'
    end
  end

  def show
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to @address
    else
      render 'edit'
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to addresss_path
  end

private

  def address_params
    params.require(:address).permit(:street_address, :street_address2, :city, :state, :zip )
  end
end

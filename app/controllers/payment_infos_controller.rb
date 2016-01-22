class PaymentInfosController < ApplicationController
  def index
    @user = current_user
    @payment_infos = @user.payment_infos
  end

  def new
    @payment_info = PaymentInfo.new
  end

  def edit
    @payment_info = PaymentInfo.find(params[:id])
  end

  def create
    @user = current_user
    @payment_info = PaymentInfo.new(payment_info_params)
    @user.payment_infos << @payment_info
    if @payment_info.save!
      redirect_to "/payment_infos"
    else
      render 'new'
    end
  end

  def show
    @payment_info = PaymentInfo.find(params[:id])
  end

  def update
    @payment_info = PaymentInfo.find(params[:id])
    if @payment_info.update(payment_info_params)
      redirect_to @payment_info
    else
      render 'edit'
    end
  end

  def destroy
    @payment_info = PaymentInfo.find(params[:id])
    @payment_info.destroy
    redirect_to "/payment_infos"
  end

private

  def payment_info_params
    params.require(:payment_info).permit(:credit_card_hash, :expiration_hash, :cvc_hash, :name_on_card, :address_id)
  end
end



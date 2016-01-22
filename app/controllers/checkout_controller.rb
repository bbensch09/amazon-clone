class CheckoutController < ApplicationController

  def checkout
    @user = current_user
    @addresses = @user.addresses
    @payment_infos = @user.payment_infos
    render 'checkout'
  end

  def save_checkout

  end
end

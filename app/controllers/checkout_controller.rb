class CheckoutController < ApplicationController

  def checkout
    @user = current_user
    @addresses = @user.addresses
    render 'checkout'
  end

  def save_checkout

  end
end

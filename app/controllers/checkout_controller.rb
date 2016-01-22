class CheckoutController < ApplicationController

  def checkout
    @user = current_user
    @addresses = @user.addresses
    @payment_infos = @user.payment_infos
    render 'checkout'
  end

  def save_checkout
    @user = current_user
    @order = @user.orders.find_by(status: 'in_cart')
    # @order.update(status: 'ordered')
    # @products = @order.shopping_cart_items
    @address = @order.address if @order
    @payment_info = @order.payment_info if @order

    render 'success'
  end
end

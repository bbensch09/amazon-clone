class CheckoutController < ApplicationController
  before_action  do
    redirect_to :root unless signed_in?
    @user = current_user
    @order = Order.where(user_id: @user.id).first
    @shopping_cart_items = @order.shopping_cart_items
  end

  def show
    # @order = @user.orders.last
    p "{@shopping_cart_items}"
    render 'checkout/cart'
  end

  def add_item
    @order.shopping_cart_items.create(quantity: params[:shopping_cart_item][:quantity], product_id: params[:product_id])
    @shopping_cart_items = @order.shopping_cart_items
    render 'checkout/cart'
  end

  def remove_item
    item_to_delete = @shopping_cart_items.where(id: params[:id]).first
    item_to_delete.destroy
    flash[:success] = "#{item_to_delete.product.title} has been removed from cart."
    render 'checkout/cart'
  end

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

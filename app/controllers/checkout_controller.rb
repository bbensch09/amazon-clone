class CheckoutController < ApplicationController
  before_action  do
    redirect_to :root unless signed_in?
    @user = current_user
    @order = @user.orders.find_by(status: 'in_cart')
    # @order = Order.where(user_id: @user.id).first
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
    item_to_delete = @shopping_cart_items.where(id: params[:id]).last
    # puts "ready to destroy: #{item_to_delete}"
    item_price_to_deduct = (item_to_delete.product.price)*(item_to_delete.quantity)
    item_to_delete.destroy
    flash[:success] = "#{item_to_delete.product.title} has been removed from cart."
    if request.xhr?
    render :nothing => true
    else
    render 'checkout/cart'
    end
    # return{amount: item_price_to_deduct}.to_json
  end

  def checkout
    # @user = current_user
    @addresses = @user.addresses
    @payment_infos = @user.payment_infos
    render 'checkout'
  end

  def save_checkout
    # @user = current_user
    # @order.update(status: 'ordered')
    # @products = @order.shopping_cart_items
    @address = @order.address if @order
    @payment_info = @order.payment_info if @order

    render 'success'
  end
end

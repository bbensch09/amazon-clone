class ShoppingCartItemsController < ApplicationController
  before_action  do
    redirect_to :root unless signed_in?
    @user = current_user
    @order = Order.where(user_id: @user.id).first
  end

  def show
    # @order = @user.orders.last
    @shopping_cart_items = @order.shopping_cart_items
    p "{@shopping_cart_items}"
    render 'checkout/cart'
  end

  def add_item
    @order.shopping_cart_items.create(quantity: params[:shopping_cart_item][:quantity], product_id: params[:product_id])
    @shopping_cart_items = @order.shopping_cart_items
    render 'checkout/cart'
  end

  def remove_item
    @shopping_cart_items = @order.shopping_cart_items
    item_to_delete = @shopping_cart_items.where(id: params[:id]).first
    item_to_delete.destroy
    flash[:success] = "#{item_to_delete.product.title} has been removed from cart."
    render 'checkout/cart'
  end
end

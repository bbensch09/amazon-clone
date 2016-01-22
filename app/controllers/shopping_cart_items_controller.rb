class ShoppingCartItemsController < ApplicationController
  before_action  do
    redirect_to :root unless signed_in?
  end
  
  def show
    @user = current_user
    @shopping_cart_items = @user.shopping_cart_items
    render 'checkout/show'
  end

end

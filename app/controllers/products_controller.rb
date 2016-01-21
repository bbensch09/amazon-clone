class ProductsController < ApplicationController

  before_action except: [:index, :show] do
    redirect_to :root unless admin?
  end

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def edit
    @product = Product.find(params[:id])
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product
    else
      render 'new'
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to @product
    else
      render 'edit'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path
  end

private

  def product_params
    params.require(:product).permit(:title, :description, :image_url, :price, :inventory_quantity, :brand_id, :category_id, :supplier_id)
  end
end

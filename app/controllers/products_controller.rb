class ProductsController < ApplicationController
  def new
    
  end

  def create
     @product = Product.new(params[:product])
     @product.save
     redirect_to tuotehallinta_path
  end

  def destroy
    Product.find(params[:id]).destroy
    redirect_to tuotehallinta_path
  end
end

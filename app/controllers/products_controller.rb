class ProductsController < ApplicationController
  def new
    
  end

  def create
     @product = Product.new(params[:product])
     if @product.save
       redirect_to tuotehallinta_path
     else
       @categories = Category.all
       @category = Category.new
       @products = Product.all
       render 'categories/tuotehallinta'
     end
  end

  def destroy
    Product.find(params[:id]).destroy
    redirect_to tuotehallinta_path
  end
end

class ProductsController < ApplicationController
  def new
    
  end

  def create
     @product = Product.new(params[:product])
     if @product.save
       redirect_to tuotehallinta_path
     else
       flash[:error] = "Lomakkeessa oli virhe"
       @categories = Category.all
       @category = Category.new
       @products = Product.all
       @product = Product.new
       render 'categories/tuotehallinta'
     end
  end

  def destroy
    Product.find(params[:id]).destroy
    redirect_to tuotehallinta_path
  end
end

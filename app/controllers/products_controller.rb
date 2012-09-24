#coding: utf-8
class ProductsController < ApplicationController
  before_filter :esimies_user, only: [:new, :create, :destroy, :update]
  def new
    
  end

  def create
     @product = Product.new(params[:product])
     if @product.save
       redirect_to tuotehallinta_path
     else
       flash[:error] = "Tuotelomakkeessa oli virhe!"
       @categories = Category.order("LOWER(kuvaus)")
       @category = Category.new
       @products = Product.order("category_id, LOWER(kuvaus)")
       @product = Product.new
       redirect_to tuotehallinta_path
     end
  end

  def update
     @product = Product.find(params[:id])
    if @product.update_attribute(:category_id, params[:product][:category_id])
      redirect_to tuotehallinta_path
    else
      redirect_to tuotehallinta_path
    end
  end

  def destroy
    Product.find(params[:id]).destroy
    redirect_to tuotehallinta_path
  end
   private
  def esimies_user
    redirect_to root_url, notice: "Kirjaudu sisään esimiehenä!" unless current_user.esimies == true
  end
end

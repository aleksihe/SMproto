#coding: utf-8
class CategoriesController < ApplicationController
  before_filter :esimies_user, only: [:tuotehallinta, :create, :destroy]
  
  def tuotehallinta
    @category = Category.new
    @categories = Category.order("LOWER(kuvaus)")
    @product = Product.new
    @products = Product.order("category_id, LOWER(kuvaus)")
    
  end
  
  def create
    @category = Category.new(params[:category])
    
    if @category.save
      redirect_to tuotehallinta_path
    else
      flash[:error] = "Tuoteryhmalomakkeessa oli virhe!"
      @categories = Category.order("LOWER(kuvaus)")
      @product = Product.new
      @products = Product.order("category_id, LOWER(kuvaus)")
      @category = Category.new
      redirect_to tuotehallinta_path
    end
  end
  
  def destroy
    Category.find(params[:id]).destroy
    redirect_to tuotehallinta_path
  end
  
  private
  
  def esimies_user
      redirect_to root_url, notice: "Kirjaudu sisään esimiehenä!" unless current_user.esimies == true
  end
end



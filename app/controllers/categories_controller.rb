class CategoriesController < ApplicationController
  def tuotehallinta
    @category = Category.new
    @categories = Category.all
    @product = Product.new
    @products = Product.all
  end
  
  def create
    @category = Category.new(params[:category])
    
    if @category.save
      redirect_to tuotehallinta_path
    else
      flash[:error] = "Tuoteryhmalomakkeessa oli virhe!"
      @categories = Category.all
      @product = Product.new
      @products = Product.all
      @category = Category.new
      redirect_to tuotehallinta_path
    end
  end
  
  def destroy
    Category.find(params[:id]).destroy
    redirect_to tuotehallinta_path
  end
  
end


#def create
#    @user = User.new(params[:user])
#    if @user.save
#     sign_in @user
#     flash[:success] = "Welcome to the Sample App!"
#     redirect_to @user
#    else
#      render 'new'
#    end
#  end
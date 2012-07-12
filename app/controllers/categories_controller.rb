class CategoriesController < ApplicationController
  def tuotehallinta
    @category = Category.new
    @categories = Category.all
  end
  
  def create
    @category = Category.new(params[:category])
    @category.save
    redirect_to tuotehallinta_path
  end
  
  def destroy
    Category.find(params[:id]).destroy
    redirect_to tuotehallinta_path
  end
  
end

#def destroy
#    if !User.find(params[:id]).admin?
#      User.find(params[:id]).destroy
#      flash[:success] = "User destroyed."
#      redirect_to users_path  
#    else
#      redirect_to users_path, notice: "Don't be stupid!"
#    end      
#  end
#def create
#   @user = User.new(params[:user])
#  if @user.save
#     sign_in @user
#     flash[:success] = "Welcome to the Sample App!"
#     redirect_to @user
#    else
#      render 'new'
#    end
#  end
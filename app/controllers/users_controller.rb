class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      if @user.esimies
          flash.now[:notice] = "Esimies luotu!"
        else
          flash.now[:notice] = "Myyja luotu!"
      end
      redirect_to new_user_path
      else
        flash[:error] = "Kayttajalomakkeessa oli virhe!"
        redirect_to root_path
    end
  end
  def index
    @users = User.all
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to users_index_path
  end  
end

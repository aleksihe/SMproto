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
      redirect_to root_path
      flash[:notice] = "Esimies luotu!"
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

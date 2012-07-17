class UsersController < ApplicationController
  def new
    @user = User.new
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
end

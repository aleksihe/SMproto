#coding: utf-8
class UsersController < ApplicationController
  before_filter :esimies_user, only: [:new, :create, :destroy, :index, :show, :update]
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
          redirect_to new_user_path
        else
          flash.now[:notice] = "Myyja luotu!"
          redirect_to myyjahallinta_path
      end
      else
        flash[:error] = "Kayttajalomakkeessa oli virhe!"
        redirect_to myyjahallinta_path
    end
  end
  
  def index
    @users = User.all
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attribute(:salegroup_id, params[:user][:salegroup_id])
      redirect_to myyjahallinta_path
    else
      redirect_to myyjahallinta_path
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to myyjahallinta_path
  end  
  private
  def esimies_user
    redirect_to root_url, notice: "Kirjaudu sisään esimiehenä!" unless current_user.esimies == true
  end
end

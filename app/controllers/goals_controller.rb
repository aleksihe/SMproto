#coding: utf-8
class GoalsController < ApplicationController
  def new
    @users = User.where(:esimies => false).order("LOWER(nimi)")
    
    if cookies[:user_id].nil?
      @user = User.where(:esimies => false).order("LOWER(nimi)").first
    else
      @user = User.find(cookies[:user_id])
    end
    @goal = Goal.new
  end

  def tavoite_myyjavaihto
    @goal = Goal.new
    cookies[:user_id] = params[:user_id]
    @user = User.find(params[:user_id])
    
    respond_to do |format|
      format.js
    end    
  end

  def create
    @goal = Goal.new(params[:goal])
    if @goal.save
      redirect_to new_goal_path
    else
      flash[:error] = "Tavoitteen luonti epäonnistui"
      redirect_to new_goal_path
    end
  end

  def destroy
    Goal.find(params[:id]).destroy
    redirect_to new_goal_path
  end

  def update
  end
 
end

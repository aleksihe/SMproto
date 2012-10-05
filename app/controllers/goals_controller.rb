#coding: utf-8
class GoalsController < ApplicationController
  before_filter :esimies_user, only: [:new, :tavoite_myyjavaihto, :create, :destroy, :update]
  def new
    @users = User.where(:esimies => false).order("LOWER(nimi)")
    @user = User.find_by_id(cookies[:user_id_at_goals]) || User.where(:esimies => false).order("LOWER(nimi)").first
    @goal = Goal.new
  end

  def tavoite_myyjavaihto
    @goal = Goal.new
    cookies[:user_id_at_goals] = { :value => params[:user_id], :expires => 10.minutes.from_now }
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
      flash[:error] = "Tavoitteen luonti epäonnistui! Täytithän kaikki kentät? Huomioi myös, että tavoitteen loppuhetken tulee olla alkuhetken jälkeen!"
      redirect_to new_goal_path
    end
  end

  def destroy
    Goal.find(params[:id]).destroy
    redirect_to new_goal_path
  end

  def update
  end
 private
  def esimies_user
    redirect_to root_url, notice: "Kirjaudu sisään esimiehenä!" unless current_user.esimies == true
  end
end

#coding: utf-8
class BonuslevelsController < ApplicationController
  def new
    @salegroups = Salegroup.all
    if cookies[:salegroup_id].nil?    
      @salegroup = Salegroup.first
    else
      @salegroup = Salegroup.find(cookies[:salegroup_id])
    end
    @bonustasot = Bonuslevel.where("salegroup_id = ? and laji = ?", @salegroup.id, "kkbonus")
    @bonustasot.sort!{|taso1, taso2| taso1.bonus_maara <=> taso2.bonus_maara}
    @new_bonustaso = Bonuslevel.new
  end

  def create
    @new_bonustaso = Bonuslevel.new(params[:bonuslevel])
    if @new_bonustaso.save
      redirect_to new_bonuslevel_path
    else
     flash[:error] = "Bonustason luominen epäonnistui"
     redirect_to new_bonuslevel_path
    end
  end

  def bonus_ryhmavaihto
    @salegroups = Salegroup.all
    @salegroup = Salegroup.find(params[:salegroup_id])
    cookies[:salegroup_id] = params[:salegroup_id]  
    @new_bonustaso = Bonuslevel.new
    @bonustasot = Bonuslevel.where("salegroup_id = ? and laji = ?", @salegroup.id, "kkbonus")
    @bonustasot.sort!{|taso1, taso2| taso1.bonus_maara <=> taso2.bonus_maara}
    redirect_to new_bonuslevel_path
     
  end

  def destroy
    Bonuslevel.find(params[:id]).destroy
    redirect_to new_bonuslevel_path
  end

  def update
    @bonustaso = Bonuslevel.find(params[:id])
     @bonustaso.update_attributes(params[:bonuslevel])
      if cookies[:salegroup_id].nil?    
      @salegroup = Salegroup.first
      else
        @salegroup = Salegroup.find(cookies[:salegroup_id])
      end
     
     respond_to do |format|
      format.js
    end
  end
end
 
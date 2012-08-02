#coding: utf-8
class MyyntiryhmatController < ApplicationController

  def ryhmavaihto
    @salegroups = Salegroup.all
    @salegroup = Salegroup.find(params[:salegroup_id])
    cookies[:salegroup_id] = params[:salegroup_id]
    @aika = cookies[:aika] || "Tänään"
    @myyjat = User.where(:salegroup_id => @salegroup.id) 
    
    respond_to do |format|
      format.js
    end   

  end

  def aikavaihto
    @aika = params[:aika]
    cookies[:aika] = params[:aika]
    @salegroup = Salegroup.find(cookies[:salegroup_id])
    @myyjat = User.where(:salegroup_id => @salegroup.id)
    respond_to do |format|
      format.js 
     end
  end

  def myyjavaihto
  end
end

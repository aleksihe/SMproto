#coding: utf-8
class MyyntiryhmatController < ApplicationController

  def ryhmavaihto
    @salegroups = Salegroup.all
    @salegroup = Salegroup.find(params[:salegroup_id])
    cookies[:salegroup_id] = params[:salegroup_id]
    @aika = cookies[:aika] || "Tänään"
    @myyjat = User.where(:salegroup_id => @salegroup.id) 
    @myyja_valittu = @myyjat.first
    cookies[:myyja_id] = @myyja_valittu.id
    respond_to do |format|
      format.js
    end   

  end

  def aikavaihto
    @aika = params[:aika]
    cookies[:aika] = params[:aika]
    
    if !cookies[:salegroup_id].nil?
      @salegroup = Salegroup.find(cookies[:salegroup_id])
    else
      @salegroup = Salegroup.first
    end
    @myyjat = User.where(:salegroup_id => @salegroup.id)
    
    if !cookies[:myyja_id].nil?
      @myyja_valittu = User.find(cookies[:myyja_id])
    else
      @myyja_valittu = @myyjat.first
    end
    
    respond_to do |format|
      format.js 
     end
  end

  def myyjavaihto
    @aika = cookies[:aika] || "Tänään"
    cookies[:myyja_id] = params[:myyja_id]
    if !cookies[:salegroup_id].nil?
      @salegroup = Salegroup.find(cookies[:salegroup_id])
    else
      @salegroup = Salegroup.first
    end
    @myyjat = User.where(:salegroup_id => @salegroup.id)
    @myyja_valittu = User.find(params[:myyja_id])
    
     respond_to do |format|
      format.js 
     end
  end
end

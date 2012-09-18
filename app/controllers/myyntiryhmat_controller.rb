#coding: utf-8
class MyyntiryhmatController < ApplicationController
   before_filter :esimies_user, only: [:myyjavaihto, :aikavaihto, :ryhmavaihto]
  def ryhmavaihto
    @salegroups = Salegroup.order("LOWER(nimi)")
    @salegroup = Salegroup.find(params[:salegroup_id])
    cookies[:salegroup_id_at_myyntiryhmat] = params[:salegroup_id]
    @aika = cookies[:aika_at_myyntiryhmat] || "Tänään"
    @myyjat = User.where(:salegroup_id => @salegroup.id) 
    
    #myyjien järjestys
    if @myyjat.count >1
      if @aika == "Tänään"
        @myyjat.sort!{|myyja2, myyja1| myyja1.sales_sum(Date.today, nil) <=> myyja2.sales_sum(Date.today, nil)}
      elsif @aika == "Tämä kuu"
        @myyjat.sort!{|myyja2, myyja1| myyja1.sales_sum(Time.zone.now.beginning_of_month, Time.zone.now.end_of_month) <=> myyja2.sales_sum(Time.zone.now.beginning_of_month, Time.zone.now.end_of_month)}
      end
    end
    
    @myyja_valittu = @myyjat.first
    cookies[:myyja_id_at_myyntiryhmat] = @myyja_valittu.id
    respond_to do |format|
      format.js
    end   

  end

  def aikavaihto
    @aika = params[:aika]
    cookies[:aika_at_myyntiryhmat] = params[:aika]
    
    if !cookies[:salegroup_id_at_myyntiryhmat].nil?
      @salegroup = Salegroup.find(cookies[:salegroup_id_at_myyntiryhmat])
    else
      @salegroup = Salegroup.first
    end
    @myyjat = User.where(:salegroup_id => @salegroup.id)
    
    #myyjien järjestys
    if @aika == "Tänään"
      @myyjat.sort!{|myyja2, myyja1| myyja1.sales_sum(Date.today, nil) <=> myyja2.sales_sum(Date.today, nil)}
    elsif @aika == "Tämä kuu"
      @myyjat.sort!{|myyja2, myyja1| myyja1.sales_sum(Time.zone.now.beginning_of_month, Time.zone.now.end_of_month) <=> myyja2.sales_sum(Time.zone.now.beginning_of_month, Time.zone.now.end_of_month)}
    end
    
    if !cookies[:myyja_id_at_myyntiryhmat].nil?
      @myyja_valittu = User.find(cookies[:myyja_id_at_myyntiryhmat])
    else
      @myyja_valittu = @myyjat.first
    end
    
    respond_to do |format|
      format.js 
     end
  end

  def myyjavaihto
    @aika = cookies[:aika_at_myyntiryhmat] || "Tänään"
    cookies[:myyja_id_at_myyntiryhmat] = params[:myyja_id]
    if !cookies[:salegroup_id_at_myyntiryhmat].nil?
      @salegroup = Salegroup.find(cookies[:salegroup_id_at_myyntiryhmat])
    else
      @salegroup = Salegroup.first
    end
    @myyjat = User.where(:salegroup_id => @salegroup.id)
    @myyja_valittu = User.find(params[:myyja_id])
    
    #myyjien järjestys
    if @aika == "Tänään"
      @myyjat.sort!{|myyja2, myyja1| myyja1.sales_sum(Date.today, nil) <=> myyja2.sales_sum(Date.today, nil)}
    elsif @aika == "Tämä kuu"
      @myyjat.sort!{|myyja2, myyja1| myyja1.sales_sum(Time.zone.now.beginning_of_month, Time.zone.now.end_of_month) <=> myyja2.sales_sum(Time.zone.now.beginning_of_month, Time.zone.now.end_of_month)}
    end
    
     respond_to do |format|
      format.js 
     end
  end
   private
  def esimies_user
    redirect_to root_url, notice: "Kirjaudu sisään esimiehenä!" unless current_user.esimies == true
  end
end

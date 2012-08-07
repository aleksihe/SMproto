#coding: utf-8
class PagesController < ApplicationController
  def esimies_main
  end
  
  def kokonaismyynti
  end
  
  def myyntiryhmat
    @aika = cookies[:aika] || "Tänään"
    @salegroups = Salegroup.all
    if !cookies[:salegroup_id].nil?
      @salegroup = Salegroup.find(cookies[:salegroup_id])
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
    
    
    
    if !cookies[:myyja_id].nil?
      @myyja_valittu = User.find(cookies[:myyja_id])
    else
       @myyja_valittu = @myyjat.first
       cookies[:myyja_id] = @myyja_valittu.id
    end   
  end
  
  def kilpailut
  end
  
  def myyja_main
    @products = Category.find(Salegroup.find(current_user.salegroup_id).category_id).products
    @contacts_today = current_user.contacts_count(Date.today, nil)
    @sales_today = current_user.sales_sum(Date.today, nil)
    @provisio_today = current_user.provisio_sum(Date.today, nil)
    @provisio_month = current_user.provisio_sum(Time.zone.now.beginning_of_month, Time.zone.now.end_of_month)
    @sales_month = current_user.sales_sum(Time.zone.now.beginning_of_month, Time.zone.now.end_of_month)
    @contacts_month = current_user.contacts_count(Time.zone.now.beginning_of_month, Time.zone.now.end_of_month)
    @pull_today = current_user.pull(Date.today, nil)
    @kmprovisio_today = current_user.kmprovisio(Date.today, nil)
    @pull_month = current_user.pull(Time.zone.now.beginning_of_month, Time.zone.now.end_of_month)
    @kmprovisio_month = current_user.kmprovisio(Time.zone.now.beginning_of_month, Time.zone.now.end_of_month)
    @contacts_avg_month = current_user.contacts_avg(Date.new(Time.zone.now.year, Time.zone.now.month, 1), Date.today)
    @provisio_arvio = current_user.provisio_arvio(Date.new(Time.zone.now.year, Time.zone.now.month, 1), Date.new(Time.zone.now.year, Time.zone.now.month + 1, 1))
  end
end

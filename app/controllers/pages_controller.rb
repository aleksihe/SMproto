#coding: utf-8
class PagesController < ApplicationController
  before_filter :myyja_user, only: [:kilpailut, :kilpailuvaihto, :myyja_main]
  before_filter :esimies_user, only: [:esimies_main, :kokonaismyynti, :myyntiryhmät]
  
  def esimies_main
  end
  
  def kokonaismyynti
  end
  
  def myyntiryhmat
    @aika = cookies[:aika_at_pages] || "Tänään"
    @salegroups = Salegroup.all
    if !cookies[:salegroup_id_at_pages].nil?
      @salegroup = Salegroup.find(cookies[:salegroup_id_at_pages])
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
       cookies[:myyja_id_at_myyntiryhmat] = { :value => @myyja_valittu.id, :expires => 10.minutes.from_now }
    end   
  end
  
  def kilpailut
    if !current_user.salegroup_id.nil?
     @products = Category.find(Salegroup.find(current_user.salegroup_id).category_id).products
    end
     @provisio_month = current_user.provisio_sum(Time.zone.now.beginning_of_month, Time.zone.now.end_of_month)
     @kilpailut = current_user.competitions.all
      if !@kilpailut.empty?
       if !cookies[:kilpailu_id_at_pages].nil?
         @kilpailu = Competition.find(cookies[:kilpailu_id_at_pages])
       else
        @kilpailu = @kilpailut.first
       end
       
       @osallistujat = @kilpailu.users
       @saannot = @kilpailu.saannot
       @palkinnot = @kilpailu.prizes
       @palkinnot.sort!{|a,b| b.arvo <=> a.arvo }
      end
  end
  
  def kilpailuvaihto
    @kilpailut = current_user.competitions.all
    @kilpailu = Competition.find(params[:competition_id])
      cookies[:kilpailu_id_myyja] = { :value => params[:competition_id], :expires => 10.minutes.from_now }
    @osallistujat = @kilpailu.users
    @saannot = @kilpailu.saannot
    @palkinnot = @kilpailu.prizes
    @palkinnot.sort!{|a,b| b.arvo <=> a.arvo }
    respond_to do |format|
      format.js
    end
  end
  
  def myyja_main
    if !current_user.salegroup_id.nil?
      @products = Category.find(Salegroup.find(current_user.salegroup_id).category_id).products
      @bonus_arvio = current_user.kkbonus_arvio(Date.new(Time.zone.now.year, Time.zone.now.month, 1), Date.new(Time.zone.now.year, Time.zone.now.month + 1, 1), "myynti(e)")
    end
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
    @kmmyynti_month = current_user.kmmyynti(Time.zone.now.beginning_of_month, Time.zone.now.end_of_month)
    @contacts_avg_month = current_user.contacts_avg(Date.new(Time.zone.now.year, Time.zone.now.month, 1), Date.today)
    @provisio_arvio = current_user.provisio_arvio(Date.new(Time.zone.now.year, Time.zone.now.month, 1), Date.new(Time.zone.now.year, Time.zone.now.month + 1, 1))
    @myynti_arvio = current_user.myynti_arvio(Date.new(Time.zone.now.year, Time.zone.now.month, 1), Date.new(Time.zone.now.year, Time.zone.now.month + 1, 1))
    @contacts_arvio = current_user.contacts_arvio(Date.new(Time.zone.now.year, Time.zone.now.month, 1), Date.new(Time.zone.now.year, Time.zone.now.month + 1, 1))
  end
  private
     
    def myyja_user
      redirect_to root_url, notice: "Myyjien sivulle päästäksesi sinun tulee kirjautua sisään myyjänä." unless current_user.esimies == false
    end
    def esimies_user
      redirect_to root_url, notice: "Kirjaudu sisään esimiehenä!" unless current_user.esimies == true
    end
end

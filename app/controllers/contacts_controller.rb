#coding: utf-8
class ContactsController < ApplicationController
  before_filter :esimies_user, only: [:index, :destroy, :contact_ryhmavaihto, :contact_myyjavaihto, :contact_aikavaihto]
  
  def create
    if params[:tilaus] && params[:tuote] == ""
      flash.now[:error] = "Valitse tuote!"
    else
    
      @contact = Contact.new(:tilaus => params[:tilaus], :user_id => params[:user_id], :salegroup_id => params[:salegroup_id], :tekija => User.find(params[:user_id]).nimi)
      
      if @contact.save
        if @contact.tilaus
          @product = Product.find(params[:tuote])
          @order = Order.new(:contact_id => @contact.id, :hinta => @product.hinta, :provisio => @product.provisio, :kuvaus => @product.kuvaus, :user_id => @contact.user_id)
          
          if @order.save   
            @tilaus = 1     
              flash.now[:notice] = "Tilaus tallennettu"
          else    
              flash.now[:error] = "Tilauksen tallentaminen epaonnistui!"
          end
        else
            flash.now[:notice] = "Kontaktin tallentaminen onnistui!"
        end
       else
         flash.now[:error] = "Kontaktin tallentaminen epaonnistui!"                 
       end  
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
    @kmmyynti_month = current_user.kmmyynti(Time.zone.now.beginning_of_month, Time.zone.now.end_of_month)
    @contacts_avg_month = current_user.contacts_avg(Date.new(Time.zone.now.year, Time.zone.now.month, 1), Date.today)
    @provisio_arvio = current_user.provisio_arvio(Date.new(Time.zone.now.year, Time.zone.now.month, 1), Date.new(Time.zone.now.year, Time.zone.now.month + 1, 1))
    @bonus_arvio = current_user.kkbonus_arvio(Date.new(Time.zone.now.year, Time.zone.now.month, 1), Date.new(Time.zone.now.year, Time.zone.now.month + 1, 1), "myynti(e)")
     end
    
     @kilpailut = current_user.competitions.where('alku <= ? and loppu >= ?', Time.now, Time.now)
      if !@kilpailut.empty?
       if !cookies[:kilpailu_id_myyja].nil?
         @kilpailu = Competition.find(cookies[:kilpailu_id_myyja])
       else
        @kilpailu = @kilpailut.first
       end
       
       @osallistujat = @kilpailu.users
       @saannot = @kilpailu.saannot
       @palkinnot = @kilpailu.prizes
       @palkinnot.sort!{|a,b| b.arvo <=> a.arvo }
     end
     respond_to do |format|
      format.js
     end
  end

  def update
  end

  def destroy
    Contact.find(params[:id]).destroy
    redirect_to contacts_path
  end

  def index    
        @salegroups = Salegroup.order("LOWER(nimi)")
        @aika = cookies[:aika_at_contacts] || "Tänään"
        
        if !cookies[:salegroup_id_at_contacts].nil?
          @salegroup = Salegroup.find(cookies[:salegroup_id_at_contacts])
        else
          @salegroup = Salegroup.first
          cookies[:salegroup_id_at_contacts] = @salegroup.id
        end
        @myyjat = User.where(:salegroup_id => (cookies[:salegroup_id_at_contacts] || 1)).order("LOWER(nimi)")
        date = Date.today
        
        if cookies[:user_id_at_contacts] == "" || cookies[:user_id_at_contacts].nil?
          if @aika == "Tänään"   
            @contacts = Contact.where("salegroup_id = ? AND created_at >= ?", (cookies[:salegroup_id_at_contacts] || 1), date).order("created_at DESC")
          elsif @aika == "Tämä kuu"
            alku = date.beginning_of_month
            loppu = (date+1.month).beginning_of_month
            @contacts = Contact.where("salegroup_id = ? AND created_at >= ? AND created_at <= ?", (cookies[:salegroup_id_at_contacts] || 1), alku, loppu).order("created_at DESC")
          end
        else
           if @aika == "Tänään"   
            @contacts = Contact.where("user_id = ? AND created_at >= ?", (cookies[:user_id_at_contacts] || 1), date).order("created_at DESC")
          elsif @aika == "Tämä kuu"
            alku = date.beginning_of_month
            loppu = (date+1.month).beginning_of_month
            @contacts = Contact.where("user_id = ? AND created_at >= ? AND created_at <= ?", (cookies[:user_id_at_contacts] || 1), alku, loppu).order("created_at DESC")
          end 
        end 
  end
  
  def contact_ryhmavaihto
    @salegroups = Salegroup.order("LOWER(nimi)")
    cookies[:salegroup_id_at_contacts] = params[:salegroup_id]
    cookies[:user_id_at_contacts] = ""
    @salegroup = Salegroup.find(params[:salegroup_id])        
    @aika = cookies[:aika_at_contacts] || "Tänään"
    date = Date.today
    if @aika == "Tänään"
      @contacts = Contact.where("salegroup_id = ? AND created_at >= ?", params[:salegroup_id], date).order("created_at DESC")
    elsif @aika == "Tämä kuu"
          alku = date.beginning_of_month
          loppu = (date+1.month).beginning_of_month
      @contacts = Contact.where("salegroup_id = ? AND created_at >= ? AND created_at <= ?", params[:salegroup_id], alku, loppu).order("created_at DESC")
    end
    
    @myyjat = User.where(:salegroup_id => params[:salegroup_id]).order("LOWER(nimi)")
    
    respond_to do |format|
      format.js
    end
  end
  
  def contact_myyjavaihto
    @salegroups = Salegroup.order("LOWER(nimi)")
    cookies[:user_id_at_contacts] = params[:user_id] 
    @aika = cookies[:aika_at_contacts] || "Tänään"
       date = Date.today
    if params[:user_id] == "" || params[:user_id].nil?
      if @aika == "Tänään"
          @contacts = Contact.where("salegroup_id = ? AND created_at >= ?", cookies[:salegroup_id_at_contacts], date).order("created_at DESC")
      elsif @aika == "Tämä kuu"
          alku = date.beginning_of_month
          loppu = (date+1.month).beginning_of_month
          @contacts = Contact.where("salegroup_id = ? AND created_at >= ? AND created_at <= ?", cookies[:salegroup_id_at_contacts], alku,loppu).order("created_at DESC")
      end
    else
      if @aika == "Tänään"
          @contacts = Contact.where("user_id = ? AND created_at >= ?", params[:user_id], date).order("created_at DESC")
      elsif @aika == "Tämä kuu"
          alku = date.beginning_of_month
          loppu = (date+1.month).beginning_of_month
          @contacts = Contact.where("user_id = ? AND created_at >= ? AND created_at <= ?", params[:user_id], alku,loppu).order("created_at DESC")
      end
    end
     respond_to do |format|
      format.js
    end
  end
  
  def contact_aikavaihto
    @aika = params[:aika]
    cookies[:aika_at_contacts] = params[:aika]
    date = Date.today
    alku = date.beginning_of_month
    loppu = (date+1.month).beginning_of_month
    if cookies[:user_id_at_contacts] == "" || cookies[:user_id_at_contacts].nil?
       if @aika == "Tänään"   
          @contacts = Contact.where("salegroup_id = ? AND created_at >= ?", (cookies[:salegroup_id_at_contacts] || 1), date).order("created_at DESC")
        elsif @aika == "Tämä kuu"
           @contacts = Contact.where("salegroup_id = ? AND created_at >= ? AND created_at <= ?", (cookies[:salegroup_id_at_contacts] || 1), alku, loppu).order("created_at DESC")
        end
    else
        if @aika == "Tänään"   
          @contacts = Contact.where("user_id = ? AND created_at >= ?", cookies[:user_id_at_contacts], date).order("created_at DESC")
        elsif @aika == "Tämä kuu"
           @contacts = Contact.where("user_id = ? AND created_at >= ? AND created_at <= ?", cookies[:user_id_at_contacts], alku, loppu).order("created_at DESC")
        end   
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

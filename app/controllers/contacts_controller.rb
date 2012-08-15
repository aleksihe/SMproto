#coding: utf-8
class ContactsController < ApplicationController
  def create
    if params[:tilaus] && params[:tuote] == ""
      flash[:error] = "Valitse tuote!"
      redirect_to myyja_main_path
      
    else
    
      @contact = Contact.new(:tilaus => params[:tilaus], :user_id => params[:user_id], :salegroup_id => params[:salegroup_id])
      
      if @contact.save
        if @contact.tilaus
          @product = Product.find(params[:tuote])
          @order = Order.new(:contact_id => @contact.id, :hinta => @product.hinta, :provisio => @product.provisio, :kuvaus => @product.kuvaus, :user_id => @contact.user_id)
          
          if @order.save        
              redirect_to myyja_main_path
          else    
              flash[:error] = "Tilauksen tallentaminen epaonnistui!"
          end
        else
            redirect_to myyja_main_path    
        end
       else
         flash[:error] = "Kontaktin tallentaminen epaonnistui!"
         redirect_to myyja_main_path                  
       end  
     end
  end

  def update
  end

  def destroy
  end

  def index    
        @salegroups = Salegroup.order("LOWER(nimi)")
        @aika = cookies[:aika] || "Tänään"
        
        if !cookies[:salegroup_id].nil?
          @salegroup = Salegroup.find(cookies[:salegroup_id])
        else
          @salegroup = Salegroup.first
          cookies[:salegroup_id] = @salegroup.id
        end
        @myyjat = User.where(:salegroup_id => (cookies[:salegroup_id] || 1)).order("LOWER(nimi)")
        date = Date.today
        
        if cookies[:user_id] == "" || cookies[:user_id].nil?
          if @aika == "Tänään"   
            @contacts = Contact.where("salegroup_id = ? AND created_at >= ?", (cookies[:salegroup_id] || 1), date).order("created_at DESC")
          elsif @aika == "Tämä kuu"
            alku = date.beginning_of_month
            loppu = (date+1.month).beginning_of_month
            @contacts = Contact.where("salegroup_id = ? AND created_at >= ? AND created_at <= ?", (cookies[:salegroup_id] || 1), alku, loppu).order("created_at DESC")
          end
        else
           if @aika == "Tänään"   
            @contacts = Contact.where("user_id = ? AND created_at >= ?", (cookies[:user_id] || 1), date).order("created_at DESC")
          elsif @aika == "Tämä kuu"
            alku = date.beginning_of_month
            loppu = (date+1.month).beginning_of_month
            @contacts = Contact.where("user_id = ? AND created_at >= ? AND created_at <= ?", (cookies[:user_id] || 1), alku, loppu).order("created_at DESC")
          end 
        end 
  end
  
  def contact_ryhmavaihto
    @salegroups = Salegroup.order("LOWER(nimi)")
    cookies[:salegroup_id] = params[:salegroup_id]
    cookies[:user_id] = ""
    @salegroup = Salegroup.find(params[:salegroup_id])        
    @aika = cookies[:aika] || "Tänään"
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
    cookies[:user_id] = params[:user_id] 
    @aika = cookies[:aika] || "Tänään"
       date = Date.today
    if params[:user_id] == "" || params[:user_id].nil?
      if @aika == "Tänään"
          @contacts = Contact.where("salegroup_id = ? AND created_at >= ?", cookies[:salegroup_id], date).order("created_at DESC")
      elsif @aika == "Tämä kuu"
          alku = date.beginning_of_month
          loppu = (date+1.month).beginning_of_month
          @contacts = Contact.where("salegroup_id = ? AND created_at >= ? AND created_at <= ?", cookies[:salegroup_id], alku,loppu).order("created_at DESC")
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
    cookies[:aika] = params[:aika]
    date = Date.today
    alku = date.beginning_of_month
    loppu = (date+1.month).beginning_of_month
    if cookies[:user_id] == "" || cookies[:user_id].nil?
       if @aika == "Tänään"   
          @contacts = Contact.where("salegroup_id = ? AND created_at >= ?", (cookies[:salegroup_id] || 1), date).order("created_at DESC")
        elsif @aika == "Tämä kuu"
           @contacts = Contact.where("salegroup_id = ? AND created_at >= ? AND created_at <= ?", (cookies[:salegroup_id] || 1), alku, loppu).order("created_at DESC")
        end
    else
        if @aika == "Tänään"   
          @contacts = Contact.where("user_id = ? AND created_at >= ?", cookies[:user_id], date).order("created_at DESC")
        elsif @aika == "Tämä kuu"
           @contacts = Contact.where("user_id = ? AND created_at >= ? AND created_at <= ?", cookies[:user_id], alku, loppu).order("created_at DESC")
        end   
    end 
    respond_to do |format|
      format.js
    end
    
  end
  
end

class ContactsController < ApplicationController
  def create
    if params[:tuote] == ""
      flash[:error] = "Valitse tuote!"
      redirect_to myyja_main_path
      
    else
    
      @contact = Contact.new(:tilaus => params[:tilaus], :user_id => params[:user_id])
      
      if @contact.save
        if @contact.tilaus
          @product = Product.find(params[:tuote])
          @order = Order.new(:contact_id => @contact.id, :hinta => @product.hinta, :provisio => @product.provisio, :kuvaus => @product.kuvaus, :user_id => @contact.user_id)
          
          if @order.save        
              redirect_to myyja_main_path
          end
          
        end      
      end  
    end
    
    
    
  end

  def update
  end

  def destroy
  end

  def index
  end
end

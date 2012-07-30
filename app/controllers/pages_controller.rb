class PagesController < ApplicationController
  def esimies_main
  end
  
  def kokonaismyynti
  end
  
  def myyntiryhmat
    @salegroups = Salegroup.all
    if params[:salegroup_id].nil? || params[:salegroup_id] == ""
      @salegroup = Salegroup.first    
    else
      @salegroup = Salegroup.find(params[:salegroup_id])
    end
    @myyjat = User.where(:salegroup_id => @salegroup.id)
    
  end
  
  def kilpailut
  end
  
  def myyja_main
    @products = Category.find(Salegroup.find(current_user.salegroup_id).category_id).products
    @contacts_today = current_user.contacts_today
    @sales_today = current_user.sales_today
    @provisio_today = current_user.provisio_today
    @provisio_month = current_user.provisio_month
    @sales_month = current_user.sales_month
    @contacts_month = current_user.contacts_month
    @pull_today = current_user.pull_today
    @kmprovisio_today = current_user.kmprovisio_today
    @pull_month = current_user.pull_month
    @kmprovisio_month = current_user.kmprovisio_month
    @contacts_avg = current_user.contacts_avg
    @provisio_arvio = current_user.provisio_arvio
  end
end

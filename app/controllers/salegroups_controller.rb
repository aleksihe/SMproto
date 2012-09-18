#coding: utf-8
class SalegroupsController < ApplicationController
   before_filter :esimies_user, only: [:create, :destroy, :myyjahallinta, :update]
  def myyjahallinta
    @myyjat = User.where(:esimies => false).order("salegroup_id, LOWER(nimi)")
    @myyja = User.new
    @salegroup = Salegroup.new
    @salegroups = Salegroup.order("LOWER(nimi)")
    @categories = Category.order("LOWER(kuvaus)")
  end

  def create
    @salegroup = Salegroup.new(params[:salegroup])
    
    if @salegroup.save
      flash[:notice] = "Myyjaryhma luotu!"
      @category = Category.find(@salegroup.category_id)
      @category.update_attributes(:salegroup_id => @salegroup.id)
      
      redirect_to myyjahallinta_path
    else
      flash[:error] = "Myyjaryhmalomakkeessa oli virhe!"
      redirect_to myyjahallinta_path
    end
  end

  def update
    @salegroup = Salegroup.find(params[:id])
    if @salegroup.update_attribute(:category_id, params[:salegroup][:category_id])
      redirect_to myyjahallinta_path
    else
      redirect_to myyjahallinta_path
    end
  end

  def destroy
    Salegroup.find(params[:id]).destroy
    redirect_to myyjahallinta_path
  end
  private
  def esimies_user
    redirect_to root_url, notice: "Kirjaudu sisään esimiehenä!" unless current_user.esimies == true
  end
end

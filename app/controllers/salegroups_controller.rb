class SalegroupsController < ApplicationController
  def myyjahallinta
    @myyjat = User.where(:esimies => false)
    @myyja = User.new
    @salegroup = Salegroup.new
    @salegroups = Salegroup.all
  end

  def create
    @salegroup = Salegroup.new(params[:salegroup])
    
    if @salegroup.save
      flash[:notice] = "Myyjaryhma luotu!"
      redirect_to myyjahallinta_path
    else
      flash[:error] = "Myyjaryhmalomakkeessa oli virhe!"
      redirect_to myyjahallinta_path
    end
  end

  def destroy
    Salegroup.find(params[:id]).destroy
    redirect_to myyjahallinta_path
  end
end

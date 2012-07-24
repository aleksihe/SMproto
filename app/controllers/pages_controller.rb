class PagesController < ApplicationController
  def esimies_main
  end
  def kokonaismyynti
  end
  def myyntiryhmat
  end
  def kilpailut
  end
  def myyja_main
    @products = Category.find(Salegroup.find(current_user.salegroup_id).category_id).products
    @contacts_today = current_user.contacts_today
    @sales_today = current_user.sales_today
    @provisio_today = current_user.provisio_today
    @provisio_palkkakausi = current_user.provisio_palkkakausi
  end
end

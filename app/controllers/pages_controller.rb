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
  end
end

class AddCategoryIdToSalegroups < ActiveRecord::Migration
  def change
    add_column :salegroups, :category_id, :int
  end
end

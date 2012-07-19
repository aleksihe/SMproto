class AddSalegroupIdToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :salegroup_id, :int
  end
end

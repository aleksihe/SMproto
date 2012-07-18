class AddSalegroupIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :salegroup_id, :int
  end
end

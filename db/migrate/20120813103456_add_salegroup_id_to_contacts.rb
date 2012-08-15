class AddSalegroupIdToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :salegroup_id, :int
  end
end

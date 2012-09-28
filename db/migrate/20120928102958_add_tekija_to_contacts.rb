class AddTekijaToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :tekija, :string
  end
end

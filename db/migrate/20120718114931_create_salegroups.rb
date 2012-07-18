class CreateSalegroups < ActiveRecord::Migration
  def change
    create_table :salegroups do |t|
      t.string :nimi

      t.timestamps
    end
  end
end

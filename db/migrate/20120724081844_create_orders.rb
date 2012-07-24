class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :contact_id
      t.integer :hinta
      t.integer :provisio
      t.string :kuvaus

      t.timestamps
    end
  end
end

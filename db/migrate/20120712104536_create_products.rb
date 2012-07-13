class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.text :kuvaus
      t.integer :hinta
      t.integer :provisio
      t.integer :category_id

      t.timestamps
    end
  end
end

class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.integer :user_id
      t.integer :salegroup_id
      t.string :kohde
      t.datetime :alku
      t.datetime :loppu
      t.integer :tyyppi
      t.decimal :maara

      t.timestamps
    end
  end
end

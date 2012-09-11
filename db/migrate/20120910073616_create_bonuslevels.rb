class CreateBonuslevels < ActiveRecord::Migration
  def change
    create_table :bonuslevels do |t|
      t.string :kriteeri
      t.integer :ehto
      t.integer :bonus_maara
      t.string :laji
      t.integer :tasonro
      t.integer :salegroup_id

      t.timestamps
    end
  end
end

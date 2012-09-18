class CreatePrizes < ActiveRecord::Migration
  def change
    create_table :prizes do |t|
     t.integer  :competition_id
    t.string   :kuvaus
    t.decimal  :arvo

      t.timestamps
    end
  end
end
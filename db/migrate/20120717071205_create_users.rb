class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nimi
      t.string :tunnus
      t.string :password_digest
      t.boolean :esimies

      t.timestamps
    end
  end
end

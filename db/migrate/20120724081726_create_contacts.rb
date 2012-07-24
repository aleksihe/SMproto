class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.boolean :tilaus
      t.integer :user_id

      t.timestamps
    end
  end
end

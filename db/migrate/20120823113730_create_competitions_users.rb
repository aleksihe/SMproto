class CreateCompetitionsUsers < ActiveRecord::Migration
  def change
    create_table :competitions_users do |t|
      t.integer :user_id
      t.integer :competition_id

     
    end
  end
end

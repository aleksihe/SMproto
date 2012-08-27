class DropCompetitionsUsers < ActiveRecord::Migration
  def up
    drop_table :competitions_users
  end

  def down
  end
end

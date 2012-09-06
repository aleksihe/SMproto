class ChangeColumnTypeInMyGoalsTable < ActiveRecord::Migration
  def self.up
    change_column :goals, :tyyppi, :string
  end

  def self.down
    change_column :goals, :tyyppi, :integer
  end
end

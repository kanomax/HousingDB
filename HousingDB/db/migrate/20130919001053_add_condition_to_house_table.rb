class AddConditionToHouseTable < ActiveRecord::Migration
  def up
    add_column :houses, :condition, :string
    add_column :houses, :quality, :string
  end
  
  def down
    remove_column :houses, :condition, :string
    remove_column :houses, :quality, :string
  end
end

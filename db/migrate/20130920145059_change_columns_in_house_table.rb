class ChangeColumnsInHouseTable < ActiveRecord::Migration
  def up
    change_column :houses, :bedrooms, :decimal
    change_column :houses, :fireplaces, :decimal
    change_column :houses, :woodstoves, :decimal
    change_column :houses, :basementbath, :decimal
    change_column :houses, :basementbd, :decimal
  end

  def down
        change_column :houses, :bedrooms, :integer
    change_column :houses, :fireplaces, :integer
    change_column :houses, :woodstoves, :integer
    change_column :houses, :basementbath, :integer
    change_column :houses, :basementbd, :integer
  end
end

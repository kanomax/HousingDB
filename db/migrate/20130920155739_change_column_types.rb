class ChangeColumnTypes < ActiveRecord::Migration
  def up
    change_column :houses, :bedrooms, :decimal, :precision => 4, :scale => 2
    change_column :houses, :fireplaces, :decimal, :precision => 4, :scale => 2
    change_column :houses, :woodstoves, :decimal, :precision => 4, :scale => 2
    change_column :houses, :basementbath, :decimal, :precision => 4, :scale => 2
    change_column :houses, :basementbd, :decimal, :precision => 4, :scale => 2
  end

  def down
        change_column :houses, :bedrooms, :integer
    change_column :houses, :fireplaces, :integer
    change_column :houses, :woodstoves, :integer
    change_column :houses, :basementbath, :integer
    change_column :houses, :basementbd, :integer
  end
end

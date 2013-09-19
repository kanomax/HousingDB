class FixGaragestalls < ActiveRecord::Migration
  def up
    change_column :houses, :garagestalls, :string
  end

  def down
    change_column :houses, :garagestalls, :integer
  end
end

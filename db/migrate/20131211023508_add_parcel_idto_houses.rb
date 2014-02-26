class AddParcelIdtoHouses < ActiveRecord::Migration
  def up
    add_column :houses, :parcel_id, :integer
  end

  def down
    remove_column :houses, :parcel_id
  end
end

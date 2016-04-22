class AddHouseIdToHousefiles < ActiveRecord::Migration
  def change
    change_table :housefiles do |t|
      t.references :house 
    end
  end
end

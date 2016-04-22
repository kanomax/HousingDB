class CreateHousefiles < ActiveRecord::Migration
  def change
    create_table :housefiles do |t|

      t.timestamps
    end
  end
end

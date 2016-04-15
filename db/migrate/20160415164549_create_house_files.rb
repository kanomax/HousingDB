class CreateHouseFiles < ActiveRecord::Migration
  def change
    create_table :housefiles do |t|
      t.belongs_to :house, index: true
      t.string :file_name
      t.string :file_content_type
      t.integer :file_size
      t.integer :file_updated_at
      t.timestamps null: false
    end
  end
end

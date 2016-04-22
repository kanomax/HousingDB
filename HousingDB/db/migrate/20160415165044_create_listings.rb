class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.belongs_to :house
      t.references :agent
      t.integer :listingprice
      t.date :listingdate
      t.timestamps null: false
    end
  end
end

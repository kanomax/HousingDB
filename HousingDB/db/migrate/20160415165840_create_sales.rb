class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.belongs_to :house
      t.belongs_to :agent
      t.integer :price
      t.date :saledate
      t.integer :contractprice
      t.string :concession
      t.string :specialterms
      t.integer :dom
      t.timestamps null: false
    end
  end
end

class CreateHouses < ActiveRecord::Migration
  def change
    create_table :houses do |t|
      t.string :address
      t.string :city
      t.string :state
      t.integer :zipcode
      t.string :county
      t.integer :lotsize
      t.integer :squarefeet
      t.decimal :bedrooms,precision: 4,scale: 2
      t.decimal :bathrooms
      t.string :style
      t.integer :year
      t.integer :basementsf
      t.integer :basementsffinish
      t.decimal :basementbd,precision: 4,scale: 2
      t.decimal :basementbath,precision: 4,scale: 2
      t.text :basementother
      t.string :garagestalls
      t.string :heating
      t.string :cooling
      t.string :siding
      t.boolean :replwindows
      t.string :outbuilding
      t.decimal :fireplaces,precision: 4,scale: 2
      t.decimal :woodstoves,precision: 4,scale: 2
      t.string :gencomments
      t.string :status
      t.integer :currentprice
      t.string :condition
      t.string :quality
      t.boolean :concretedrive
      t.boolean :sprinklers
      t.integer :parcel_id
      t.text :attachments
      t.string :houseimg_file_name
      t.string :houseimg_content_type
      t.integer :houseimg_file_size
      t.datetime :houseimg_updated_at
      t.timestamps null: false
      
    end
  end
end

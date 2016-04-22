class AddAttachmentHouseimgToHouses < ActiveRecord::Migration
  def self.up
    change_table :houses do |t|
      t.attachment :houseimg
    end
  end

  def self.down
    drop_attached_file :houses, :houseimg
  end
end

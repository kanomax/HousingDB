class AddAttachmentFileToHousefiles < ActiveRecord::Migration
  def self.up
    change_table :housefiles do |t|
      t.attachment :file
    end
  end

  def self.down
    drop_attached_file :housefiles, :file
  end
end

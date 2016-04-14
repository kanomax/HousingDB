class AddAttachmentstoHouse < ActiveRecord::Migration
  def up
    add_column :houses, :attachments, :text
  end

  def down
  remove_column :houses, :attachments
  end
end

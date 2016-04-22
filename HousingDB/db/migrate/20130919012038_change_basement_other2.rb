class ChangeBasementOther2 < ActiveRecord::Migration
  def up
    change_column :houses, :basementother, :text
  end

  def down
    change_column :houses, :basementother, :integer
  end
end

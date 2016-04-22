class ChangeCellphone < ActiveRecord::Migration
  def up
    change_column :agents, :cellphone, :string
  end

  def down
        change_column :agents, :cellphone, :integer
  end
end

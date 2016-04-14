class AddCellphoneToAgents < ActiveRecord::Migration
  def up
    add_column :agents, :cellphone, :integer
  end
  
  def down
    remove_column :agent, :cellphone
  end
end

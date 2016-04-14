class AddConcreteSprinklerstoHouseTable < ActiveRecord::Migration
  def up
    add_column :houses, :concretedrive, :boolean
    add_column :houses, :sprinklers, :boolean
  end

  def down
     remove_column :houses, :concretedrive, :boolean
    remove_column :houses, :sprinklers, :boolean
  end
end

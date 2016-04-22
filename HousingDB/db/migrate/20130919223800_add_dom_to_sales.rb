class AddDomToSales < ActiveRecord::Migration
  def up
    add_column :sales, :dom, :integer
  end
end

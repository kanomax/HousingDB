class AddBookAndPageToSales < ActiveRecord::Migration
  def change
    add_column :sales, :book, :int
    add_column :sales, :page, :int
  end
end

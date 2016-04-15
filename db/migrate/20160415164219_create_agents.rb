class CreateAgents < ActiveRecord::Migration
  def change
    create_table :agents do |t|
      t.belongs_to :listing, index: true
      t.string :name
      t.string :companyname
      t.string :address
      t.string :phone
      t.string :email
      t.string :cellphone
      t.timestamps null: false
    end
  end
end

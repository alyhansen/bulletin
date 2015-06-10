class CreateBuildings < ActiveRecord::Migration
  def change
    create_table :buildings do |t|
      t.string :name
      t.string :phone
      t.string :address
      t.integer :admin_id

      t.timestamps

    end
  end
end

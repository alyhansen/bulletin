class CreateSignups < ActiveRecord::Migration
  def change
    create_table :signups do |t|
      t.string :status
      t.string :building_id

      t.timestamps

    end
  end
end

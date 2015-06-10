class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :building_id
      t.integer :user_id
      t.string :image
      t.string :link
      t.string :subject
      t.string :post_type

      t.timestamps

    end
  end
end

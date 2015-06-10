class AddUserIdToSignups < ActiveRecord::Migration
  def change
    add_column :signups, :user_id, :integer
  end
end

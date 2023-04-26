class RemoveDateFromFriendships < ActiveRecord::Migration[7.0]
  def change
    remove_column :friendships, :created_at
    remove_column :friendships, :updated_at
  end
end

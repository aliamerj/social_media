class AddDefaultAvatarIdToUsers < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :avatar_id, from: nil, to: 1
  end
end

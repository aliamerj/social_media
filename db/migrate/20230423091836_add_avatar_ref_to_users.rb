class AddAvatarRefToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :avatar, null: false, foreign_key: true, default: 57
  end
end

class AddnameToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string, default: "Ali", null: false
  end
end

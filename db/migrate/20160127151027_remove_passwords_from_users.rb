class RemovePasswordsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :password, :text, null: false
    add_column :users, :password_digest, :text, null: false
  end
end

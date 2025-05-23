class AddIndexToUsersEmail < ActiveRecord::Migration[8.0]
  def change
    # Adding a unique index to the email column in the users table
    add_index :users, :email, unique: true
  end
end

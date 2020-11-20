class RenameAccountNameColumnToEndUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :end_users, :account_name, :name
  end
end

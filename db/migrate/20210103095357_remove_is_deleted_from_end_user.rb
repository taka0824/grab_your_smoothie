class RemoveIsDeletedFromEndUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :end_users, :is_deleted, :boolean
  end
end

class AddDiscardedAtToEndUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :end_users, :discarded_at, :datetime
  end
end

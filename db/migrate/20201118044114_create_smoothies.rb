class CreateSmoothies < ActiveRecord::Migration[5.2]
  def change
    create_table :smoothies do |t|
      t.integer :end_user_id
      t.string :image_id
      t.text :introduction
      t.boolean :is_recommended

      t.timestamps
    end
  end
end

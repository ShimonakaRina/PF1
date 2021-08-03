class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.integer :cook_id
      t.integer :cook_comment_id
      t.integer :visiter_id
      t.integer :visited_id
      t.string :action
      t.boolean :checked, default: false, null: false
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end

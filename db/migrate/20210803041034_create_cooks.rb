class CreateCooks < ActiveRecord::Migration[5.2]
  def change
    create_table :cooks do |t|
      t.string :title, null: false
      t.integer :tag_relationships_id
      t.integer :user_id, null: false
      t.string :body, null: false
      t.string :cook_image_id
      t.datetime :created_at
      t.datetime :update_at

      t.timestamps
    end
  end
end

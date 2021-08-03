class CreateCooks < ActiveRecord::Migration[5.2]
  def change
    create_table :cooks do |t|
      t.string :title
      t.integer :tag_relationships_id
      t.integer :user_id
      t.string :body
      t.string :cook_image_id
      t.datetime :created_at
      t.datetime :update_at

      t.timestamps
    end
  end
end

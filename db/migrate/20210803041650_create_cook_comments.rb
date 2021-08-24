class CreateCookComments < ActiveRecord::Migration[5.2]
  def change
    create_table :cook_comments do |t|
      t.integer :user_id, null: false
      t.integer :cook_id, null: false
      t.string :comment, null: false
      t.float :rate, null: false
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end

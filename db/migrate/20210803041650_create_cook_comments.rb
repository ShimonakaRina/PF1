class CreateCookComments < ActiveRecord::Migration[5.2]
  def change
    create_table :cook_comments do |t|
      t.integer :user_id
      t.integer :cook_id
      t.string :body
      t.float :rate
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end
  end
end

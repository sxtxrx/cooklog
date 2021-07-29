class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :dish_id
      t.integer :user_id
      t.text :content
      t.timestamps
    end
    add_index :comments, :user_id  # 追記
    add_index :comments, :dish_id  # 追記
  end
end

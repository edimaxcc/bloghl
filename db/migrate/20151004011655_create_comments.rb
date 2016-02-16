class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.references :user, index: true, foreign_key: true
      t.integer :post_id
      t.timestamps null: false
    end
    add_index :comments, [:user_id, :created_at]
    add_index :comments, [:post_id, :created_at]
  end
end

class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :subtitle
      t.string :bich_text
      t.integer :user_id
      t.integer :comments
      t.integer :category

      t.timestamps
    end
  end
end

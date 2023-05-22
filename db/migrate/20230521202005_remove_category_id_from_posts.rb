class RemoveCategoryIdFromPosts < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :category
    add_reference :posts, :category, null: false, foreign_key: true
  end
end

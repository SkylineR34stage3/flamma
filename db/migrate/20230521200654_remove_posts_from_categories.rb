class RemovePostsFromCategories < ActiveRecord::Migration[7.0]
  def change
    remove_column :categories, :posts
  end
end

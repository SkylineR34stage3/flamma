class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.string :text
      t.integer :post_id
      t.integer :user_id
      t.integer :reply_to

      t.timestamps
    end
  end
end

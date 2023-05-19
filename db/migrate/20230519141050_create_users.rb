class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :lastname
      t.integer :comments
      t.integer :role_id
      t.integer :posts

      t.timestamps
    end
  end
end

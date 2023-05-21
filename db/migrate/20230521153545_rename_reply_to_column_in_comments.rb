class RenameReplyToColumnInComments < ActiveRecord::Migration[7.0]
  def change
    rename_column :comments, :reply_to, :parent_id
  end
end

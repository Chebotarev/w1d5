class ChangeColumnToComments < ActiveRecord::Migration
  def change
    change_column :comments, :commentable_type, :string, null: false
  end
end

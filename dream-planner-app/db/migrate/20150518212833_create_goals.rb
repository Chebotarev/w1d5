class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.text :content, null: false
      t.integer :owner_id, null: false
      t.string :status, null: false
      t.string :title, null: false

      t.timestamps null: false
    end
    add_index :goals, :owner_id
    add_index :goals, [:owner_id, :title], unique: true
  end
end

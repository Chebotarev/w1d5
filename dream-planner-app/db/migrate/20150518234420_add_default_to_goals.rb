class AddDefaultToGoals < ActiveRecord::Migration
  def change
    change_column :goals, :status, :string, default: "public"
  end
end

class CreateCoactions < ActiveRecord::Migration
  def change
    create_table :coactions do |t|
      t.references :mission
      t.references :user
      t.string :name
      t.integer :committed_user
      t.date :deadline
      t.integer :priority

      t.timestamps
    end
    add_index :coactions, :mission_id
    add_index :coactions, :user_id
  end
end

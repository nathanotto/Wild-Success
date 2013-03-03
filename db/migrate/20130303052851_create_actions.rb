class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|
      t.references :mission
      t.references :user
      t.string :name
      t.integer :committed_user
      t.date :deadline
      t.integer :priority

      t.timestamps
    end
    add_index :actions, :mission_id
    add_index :actions, :user_id
  end
end

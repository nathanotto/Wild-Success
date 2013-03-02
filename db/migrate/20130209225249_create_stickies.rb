class CreateStickies < ActiveRecord::Migration
  def change
    create_table :stickies do |t|
      t.references :mission
      t.references :user
      t.string :name
      t.string :kind

      t.timestamps
    end
    add_index :stickies, :mission_id
    add_index :stickies, :user_id
  end
end

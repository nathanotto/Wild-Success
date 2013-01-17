class CreateAssumptions < ActiveRecord::Migration
  def change
    create_table :assumptions do |t|
      t.string :name
      t.references :mission

      t.timestamps
    end
    add_index :assumptions, :mission_id
  end
end

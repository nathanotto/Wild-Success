class CreateDrivers < ActiveRecord::Migration
  def change
    create_table :drivers do |t|
      t.string :name
      t.references :mission

      t.timestamps
    end
    add_index :drivers, :mission_id
  end
end

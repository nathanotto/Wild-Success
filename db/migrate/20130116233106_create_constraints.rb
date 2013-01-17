class CreateConstraints < ActiveRecord::Migration
  def change
    create_table :constraints do |t|
      t.string :name
      t.references :mission

      t.timestamps
    end
    add_index :constraints, :mission_id
  end
end

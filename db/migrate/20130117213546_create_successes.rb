class CreateSuccesses < ActiveRecord::Migration
  def change
    create_table :successes do |t|
      t.string :name
      t.references :mission

      t.timestamps
    end
    add_index :successes, :mission_id
  end
end

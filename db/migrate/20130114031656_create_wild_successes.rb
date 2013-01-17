class CreateWildSuccesses < ActiveRecord::Migration
  def change
    create_table :wild_successes do |t|
      t.string :success
      t.references :mission

      t.timestamps
    end
    add_index :wild_successes, :mission_id
  end
end

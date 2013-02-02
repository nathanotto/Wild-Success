class CreateClumps < ActiveRecord::Migration
  def change
    create_table :clumps do |t|
      t.references :user
      t.references :mission
      t.string :kind
      t.string :name

      t.timestamps
    end
    add_index :clumps, :user_id
    add_index :clumps, :mission_id
  end
end

class CreateFacts < ActiveRecord::Migration
  def change
    create_table :facts do |t|
      t.string :name
      t.references :mission

      t.timestamps
    end
    add_index :facts, :mission_id
  end
end

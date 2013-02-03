class AddClumpIndexesToSdcfa < ActiveRecord::Migration
  def change
      add_index :successes,   :clump_id
      add_index :drivers,     :clump_id
      add_index :constraints, :clump_id
      add_index :facts,       :clump_id
      add_index :assumptions, :clump_id

  end
end

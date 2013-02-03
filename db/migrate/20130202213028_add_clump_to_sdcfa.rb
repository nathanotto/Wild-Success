class AddClumpToSdcfa < ActiveRecord::Migration
    def change
        add_column :successes,   :clump_id, :integer
        add_column :drivers,     :clump_id, :integer
        add_column :constraints, :clump_id, :integer
        add_column :facts,       :clump_id, :integer
        add_column :assumptions, :clump_id, :integer
    end
end

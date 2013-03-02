class AddClumpsToStickes < ActiveRecord::Migration
  def change
      add_column :stickies, :clump_id, :integer
      add_index  :stickies, :clump_id
      
  end
end

class AddColumnToScfa < ActiveRecord::Migration
    # users own their contribution; owners can delete, only creator/admin can delete globally for a mission
    def change
        add_column :successes,  :user_id, :integer
        add_column :constraints, :user_id, :integer
        add_column :facts,       :user_id, :integer
        add_column :assumptions, :user_id, :integer
    end
end

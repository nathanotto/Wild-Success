class AddActionsToStickies < ActiveRecord::Migration
    def change
        add_column :stickies, :coaction_id, :integer
        add_index  :stickies, :coaction_id
        
    end
end

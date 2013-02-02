class AddIndexesToScfa < ActiveRecord::Migration
  def change
            add_index :successes,   :user_id
            add_index :constraints, :user_id
            add_index :facts,       :user_id
            add_index :assumptions, :user_id
      
  end
end

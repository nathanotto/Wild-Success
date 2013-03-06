class CreateStickiesCoactionsJoinTable < ActiveRecord::Migration
  def up
      create_table :coactions_stickies, :id => false do |t|
          t.integer :coaction_id
          t.integer :sticky_id
      end
      add_index :coactions_stickies, [:coaction_id, :sticky_id]
  end


  def down
      drop_table :coactions_stickies
  end
end

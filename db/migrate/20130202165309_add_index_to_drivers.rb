class AddIndexToDrivers < ActiveRecord::Migration
  def change
      add_index :drivers, :user_id
  end
end

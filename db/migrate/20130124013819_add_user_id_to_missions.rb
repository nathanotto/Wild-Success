class AddUserIdToMissions < ActiveRecord::Migration
  def change
    add_column :missions, :user_id, :int
  end
end

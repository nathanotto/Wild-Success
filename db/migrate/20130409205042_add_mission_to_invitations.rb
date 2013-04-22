class AddMissionToInvitations < ActiveRecord::Migration
  def change
    add_column :invitations, :mission_id, :integer
  end
end

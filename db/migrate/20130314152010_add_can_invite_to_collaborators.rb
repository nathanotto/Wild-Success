class AddCanInviteToCollaborators < ActiveRecord::Migration
  def change
    add_column :collaborators, :can_invite, :boolean
  end
end

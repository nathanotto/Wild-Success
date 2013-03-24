class AddHostUserIdToCollaborators < ActiveRecord::Migration
  def change
    add_column :collaborators, :inviter_user_id, :integer
  end
end

class AddCanInviteToStickies < ActiveRecord::Migration
  def change
    add_column :stickies, :can_invite, :boolean
  end
end

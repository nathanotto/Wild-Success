class AddMessageToInvitations < ActiveRecord::Migration
  def change
    add_column :invitations, :message, :string
  end
end

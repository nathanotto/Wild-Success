class AddConfirmedToCollaborator < ActiveRecord::Migration
  def change
    add_column :collaborators, :confirmed?, :boolean
  end
end

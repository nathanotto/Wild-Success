class RenameConfirmedInCollaborators < ActiveRecord::Migration
  def up
      rename_column :collaborators, :confirmed?, :confirmed

  end

  def down
      rename_column :collaborators, :confirmed, :confirmed?
  end
end

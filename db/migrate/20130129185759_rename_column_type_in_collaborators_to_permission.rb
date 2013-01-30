class RenameColumnTypeInCollaboratorsToPermission < ActiveRecord::Migration
  def up
   rename_column :collaborators, :type, :permission

end

  def down
   rename_column :collaborators, :permission, :type
  end
end

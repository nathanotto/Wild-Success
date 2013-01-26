class CreateCollaborators < ActiveRecord::Migration
  def change
    create_table :collaborators do |t|
      t.references :mission
      t.references :user
      t.string :type

      t.timestamps
    end
    add_index :collaborators, :mission_id
    add_index :collaborators, :user_id
  end
end

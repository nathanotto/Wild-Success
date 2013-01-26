class AddIsPublicToMissions < ActiveRecord::Migration
  def change
    add_column :missions, :is_public, :boolean
  end
end

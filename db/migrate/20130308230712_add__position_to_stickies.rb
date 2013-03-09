class AddPositionToStickies < ActiveRecord::Migration
  def change
    add_column :stickies, :position, :integer
  end
end

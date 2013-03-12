class AddPositionToCoactions < ActiveRecord::Migration
  def change
    add_column :coactions, :position, :integer
  end
end

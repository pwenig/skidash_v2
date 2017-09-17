class AddColsToRoadVolume < ActiveRecord::Migration[5.1]
  def change
    add_column :road_volumes, :day, :string
    add_column :road_volumes, :month, :string
  end
end

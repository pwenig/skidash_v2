class CreateRoadVolumes < ActiveRecord::Migration[5.1]
  def change
    create_table :road_volumes do |t|
      t.string "direction"
      t.string "volume"
      t.string "time"
      t.timestamps
    end
  end
end

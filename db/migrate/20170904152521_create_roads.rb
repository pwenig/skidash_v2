class CreateRoads < ActiveRecord::Migration[5.1]
  def change
    create_table :roads do |t|
      t.string "name"
    end
  end
end

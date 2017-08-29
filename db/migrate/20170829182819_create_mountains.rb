class CreateMountains < ActiveRecord::Migration[5.1]
  def change
    create_table :mountains do |t|
      t.string   "name"
      t.string   "zip_code"
      t.string   "lifts_open",   default: "n/a"
      t.string   "runs_open",    default: "n/a"
      t.string   "terrain_url",  default: "n/a"
      t.string   "mtn_image1"
      t.string   "mtn_image2"
      t.string   "mtn_image3"
      t.string   "base"

      t.timestamps
    end
  end
end

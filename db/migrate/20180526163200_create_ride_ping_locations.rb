class CreateRidePingLocations < ActiveRecord::Migration
  def change
    create_table :ride_ping_locations do |t|
      t.references :ride, index: true, foreign_key: true
      t.float :latitude
      t.float :longitude

      t.timestamps null: false
    end
  end
end

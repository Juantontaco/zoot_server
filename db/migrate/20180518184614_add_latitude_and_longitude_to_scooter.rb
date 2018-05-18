class AddLatitudeAndLongitudeToScooter < ActiveRecord::Migration
  def change
    add_column :scooters, :latitude, :float
    add_column :scooters, :longitude, :float
  end
end

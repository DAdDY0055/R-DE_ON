class ChangeDatatypeLatitudeLongitudeOfSpots < ActiveRecord::Migration[5.2]
  def change
    change_column :spots, :latitude, :float 
    change_column :spots, :longitude, :float
  end
end

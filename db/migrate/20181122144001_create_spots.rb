class CreateSpots < ActiveRecord::Migration[5.2]
  def change
    create_table :spots do |t|
      t.string :address
      t.integer :latitude
      t.integer :longitude
      t.string :spot_name
      t.text :spot_infomation
      t.string :spot_photo
      t.integer :user_id
      t.text :comment
      t.integer :like
      t.text :spot_tag

      t.timestamps
    end
  end
end

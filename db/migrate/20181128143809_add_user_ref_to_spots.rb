class AddUserRefToSpots < ActiveRecord::Migration[5.2]
  def change
    remove_column :spots, :user_id
    add_reference :spots, :user, foreign_key: true
  end
end

class ChangeColumnToSpot < ActiveRecord::Migration[5.2]
  def change
    change_column :spots, :like, :integer, null: false, default: 0
  end
end

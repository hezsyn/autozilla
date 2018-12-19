class AddEnabledToLocations < ActiveRecord::Migration[5.2]
  def change
    add_column :locations, :enabled, :integer
  end
end

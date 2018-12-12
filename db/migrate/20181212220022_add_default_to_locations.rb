class AddDefaultToLocations < ActiveRecord::Migration[5.2]
  def change
    add_column :locations, :default, :integer
  end
end

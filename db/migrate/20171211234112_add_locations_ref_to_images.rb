class AddLocationsRefToImages < ActiveRecord::Migration[5.1]
  def change
    add_reference :images, :location, index: true
  end
end

class AddLocationsRefToClonezillaVersions < ActiveRecord::Migration[5.1]
  def change
    add_reference :clonezilla_versions, :location, index: true
  end
end

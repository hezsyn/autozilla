class AddVersionToClonezillaVersions < ActiveRecord::Migration[5.2]
  def change
    add_column :clonezilla_versions, :version, :string
  end
end

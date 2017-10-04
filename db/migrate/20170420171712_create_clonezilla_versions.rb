class CreateClonezillaVersions < ActiveRecord::Migration[5.1]
  def change
    create_table :clonezilla_versions do |t|
      t.string            :name
      t.text              :description
      t.integer           :is_enabled
      t.integer           :default
      t.references        :upload, index: true
      t.references        :download, index: true

      t.timestamps
    end
  end
end

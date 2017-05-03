class CreateClonezillaVersions < ActiveRecord::Migration[5.0]
  def change
    create_table :clonezilla_versions do |t|
      t.string            :name
      t.text              :description
      t.text              :loader_string
      t.text              :azk_loader_string
      t.text              :azk_up_loader_string
      t.text              :up_loader_string
      t.text              :azk_syslinux_loader_string
      t.text              :azk_syslinux_up_loader_string
      t.text              :azab_loader_string
      t.integer           :is_enabled

      t.timestamps
    end
  end
end

class CreateClonezillaVersions < ActiveRecord::Migration[5.1]
  def change
    create_table :clonezilla_versions do |t|
      t.string            :name
      t.text              :description
      t.integer           :is_enabled
      t.references        :grub_upload, index: true
      t.references        :grub_download, index: true
      t.references        :syslinux_upload, index: true
      t.references        :syslinux_download, index: true

      t.timestamps
    end
  end
end

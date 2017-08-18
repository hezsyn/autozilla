class CreateClonezillaVersions < ActiveRecord::Migration[5.1]
  def change
    create_table :clonezilla_versions do |t|
      t.string            :name
      t.text              :description
      t.integer           :is_enabled
      t.references        :grub_upload, ind
      t.references        :grub_download
      t.references        :syslinux_upload
      t.references        :syslinux_download

      t.timestamps
    end
  end
end

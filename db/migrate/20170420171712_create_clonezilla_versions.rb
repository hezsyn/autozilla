class CreateClonezillaVersions < ActiveRecord::Migration[5.1]
  def change
    create_table :clonezilla_versions do |t|
      t.string            :name
      t.text              :description
      t.integer           :is_enabled
      t.integer           :grub_upload_id
      t.integer           :grub_download_id
      t.integer           :syslinux_upload_id
      t.integer           :syslinux_download_id

      t.timestamps
    end
  end
end

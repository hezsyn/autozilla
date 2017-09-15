class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.string      :name
      t.string      :azkName
      t.text        :description
      t.string      :file_location
      t.string      :disk
      t.references  :note, index: true
      t.references  :user, index: true
      t.references  :system, index: true
      t.references  :pool, index: true
      t.references  :ose, index: true
      t.references  :image_status, index: true
      t.references  :clonezilla_version, index: true
      t.references  :image_type, index: true
      t.string      :autoboot
      t.integer     :current
      t.references  :grub_upload, index: true
      t.references  :grub_download, index: true
      t.references  :syslinux_upload, index: true
      t.references  :syslinux_download, index: true

      t.timestamps
    end
  end
end


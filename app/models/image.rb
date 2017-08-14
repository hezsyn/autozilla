class Image < ApplicationRecord
  has_many   :notes
  belongs_to :pool
  belongs_to :system
  belongs_to :ose
  belongs_to :image_status
  belongs_to :clonezilla_version
  belongs_to :image_type
  belongs_to :grub_upload, class_name: "AutozillaKeyConfig", :foreign_key => :grub_upload_id
  belongs_to :grub_download, class_name: "AutozillaKeyConfig", :foreign_key => :grub_download_id
  belongs_to :syslinux_upload, class_name: "AutozillaKeyConfig", :foreign_key => :syslinux_download_id
  belongs_to :syslinux_download, class_name: "AutozillaKeyConfig", :foreign_key => :syslinux_download_id
end

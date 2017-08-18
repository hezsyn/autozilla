class ClonezillaVersion < ApplicationRecord
  has_one :images
  belongs_to :grub_upload, class_name: "AutozillaKeyConfig", foreign_key: "id"
  belongs_to :grub_download, class_name: "AutozillaKeyConfig", foreign_key: "id"
  belongs_to :syslinux_upload, class_name: "AutozillaKeyConfig", foreign_key: "id"
  belongs_to :syslinux_download, class_name: "AutozillaKeyConfig", foreign_key: "id"
end

class AutozillaKeyConfig < ApplicationRecord
  has_many :image
  has_many :grub_upload, class_name: "ClonezillaVersion", foreign_key: "grub_upload_id"
  has_many :grub_download, class_name: "ClonezillaVersion", foreign_key: "grub_download_id"
  has_many :syslinux_upload, class_name: "ClonezillaVersion", foreign_key: "syslinux_upload_id"
  has_many :syslinux_download, class_name: "ClonezillaVersion", foreign_key: "syslinux_download_id"

  def bootLine

  end

end
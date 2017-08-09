class ClonezillaVersion < ApplicationRecord
  has_one :images
  has_many :grub_upload, :class_name => "AutozillaKeyConfig"
  has_many :grub_download, :class_name => "AutozillaKeyConfig"
  has_many :syslinux_upload, :class_name => "AutozillaKeyConfig"
  has_many :syslinux_download, :class_name => "AutozillaKeyConfig"
end

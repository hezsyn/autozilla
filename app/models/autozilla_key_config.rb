class AutozillaKeyConfig < ApplicationRecord
  has_many :image
  belongs_to :grub_upload, polymorphic: true
  belongs_to :grub_download, polymorphic: true
  belongs_to :syslinux_upload, polymorphic: true
  belongs_to :syslinux_download, polymorphic: true

end
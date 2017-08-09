class AutozillaKeyConfig < ApplicationRecord
  has_many :image
  belongs_to :grub_upload, :class_name => "ClonezillaVersion" , :foreign_key => :grub_upload_id
  belongs_to :grub_upload, :class_name => "ClonezillaVersion" , :foreign_key => :grub_download_id
  belongs_to :syslinux_upload, :class_name => "ClonezillaVersion" , :foreign_key => :syslinux_upload_id
  belongs_to :syslinux_download, :class_name => "ClonezillaVersion" , :foreign_key => :syslinux_download_id
end

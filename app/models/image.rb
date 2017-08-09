class Image < ApplicationRecord
  has_many   :notes
  belongs_to :pool
  belongs_to :system
  belongs_to :ose
  belongs_to :image_status
  belongs_to :clonezilla_version
  belongs_to :image_type
  has_many :grub_upload, :class => "AutozillaKeyConfig", :foreign_key => :grub_upload_id
  has_many :grub_download, :class => "AutozillaKeyConfig", :foreign_key => :grub_download_id
  has_many :syslinux_upload, :class => "AutozillaKeyConfig", :foreign_key => :syslinux_download_id
  has_many :syslinux_download, :class => "AutozillaKeyConfig", :foreign_key => :syslinux_download_id
end

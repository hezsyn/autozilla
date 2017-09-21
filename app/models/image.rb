class Image < ApplicationRecord
  include Azk::Key

  has_many   :notes
  belongs_to :pool
  belongs_to :system
  belongs_to :ose
  belongs_to :image_status
  belongs_to :clonezilla_version
  belongs_to :image_type
  belongs_to :grub_upload, class_name: "AutozillaKeyConfig"
  belongs_to :grub_download, class_name: "AutozillaKeyConfig"
  belongs_to :syslinux_upload, class_name: "AutozillaKeyConfig"
  belongs_to :syslinux_download, class_name: "AutozillaKeyConfig"

  def azkName
    self.current == 1 ? cur = "Current - " : cur = nil
    "#{cur}" + pool.name + " - " + image_type.name + " - " + ose.name + " - bheinrix - " + updated_at.strftime("%m%b%Y")
  end

  def img_file_location
    "#{self.system.file_location}/#{self.pool.name}"
  end

end

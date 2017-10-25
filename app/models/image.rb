class Image < ApplicationRecord
  include Azk::Key

  has_many   :notes
  belongs_to :pool
  belongs_to :system
  belongs_to :ose
  belongs_to :image_status
  belongs_to :clonezilla_version
  belongs_to :image_type
  belongs_to :upload, class_name: "AutozillaKeyConfig"
  belongs_to :download, class_name: "AutozillaKeyConfig"

  def azkName
    cur = "Current - " if self.current == 1
    if self.current == 1
      "#{cur}" + pool.name + " - " + image_type.name + " - " + ose.name + " - bheinrix - " + updated_at.strftime("%d%b%Y")
    else
      pool.name + " - " + image_type.name + " - " + ose.name + " - bheinrix - " + updated_at.strftime("%d%b%Y")
    end
  end

  def img_file_location
    "#{self.system.file_location}/#{self.pool.name}"
  end


end

class Image < ApplicationRecord
  include Azk::Key

  validates :name, presence: true, uniqueness: { scope: :system_id, message: "is already in use."}, format: { with: /\A[a-zA-Z0-9\[\]\-\_\.]+\z/, message: 'invalid name - a-zA-Z0-9 []-' }
  has_many   :notes
  belongs_to :location, class_name: "Location"
  belongs_to :pool
  belongs_to :system
  belongs_to :ose
  belongs_to :image_status
  belongs_to :clonezilla_version
  belongs_to :image_type
  belongs_to :upload, class_name: "AutozillaKeyConfig"
  belongs_to :download, class_name: "AutozillaKeyConfig"

  def azkName
      pool.name + " - " + image_type.name + " - " + ose.name + " - bheinrix - " + updated_at.strftime("%d%b%Y")
  end

  def img_file_location
    "#{self.system.file_location}/#{self.pool.name}"
  end

end

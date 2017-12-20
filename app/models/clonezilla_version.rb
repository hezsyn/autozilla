class ClonezillaVersion < ApplicationRecord
  include Azk::Key

  has_one :images

  validates :name, presence: true, uniqueness: { message: "is already in use."}, format: { with: /\A[a-zA-Z0-9\[\]\-\_\.]+\z/, message: 'invalid name - a-zA-Z0-9 []-' }

  belongs_to :location, class_name: "Location"
  belongs_to :upload, class_name: "AutozillaKeyConfig"
  belongs_to :download, class_name: "AutozillaKeyConfig"
end

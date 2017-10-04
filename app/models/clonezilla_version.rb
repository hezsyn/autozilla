class ClonezillaVersion < ApplicationRecord
  has_one :images
  belongs_to :upload, class_name: "AutozillaKeyConfig"
  belongs_to :download, class_name: "AutozillaKeyConfig"
end

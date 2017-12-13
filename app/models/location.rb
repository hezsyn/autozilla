class Location < ApplicationRecord
  has_one :images
  has_one :clonezilla_versions
end

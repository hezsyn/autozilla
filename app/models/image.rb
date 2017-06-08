class Image < ApplicationRecord
  has_many :image_status
  has_many :pool
  has_many :ose
  has_many :clonezilla_version
  has_many :user
end

class Image < ApplicationRecord
  belongs_to :system
  has_many :image_statuses
  has_many :oses
  has_many :pools
end

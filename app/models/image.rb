class Image < ApplicationRecord
  belongs_to :system
  belongs_to :image_statuses
  belongs_to :oses
  belongs_to :pools
end

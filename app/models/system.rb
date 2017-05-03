class System < ApplicationRecord
  belongs_to :category
  has_many   :images
end

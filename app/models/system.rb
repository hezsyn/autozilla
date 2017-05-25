class System < ApplicationRecord
  belongs_to :category, polymorphic: true
  has_many   :images
end

class Category < ApplicationRecord
  has_many :categories
  has_many :systems

  validates :name, presence: true

end

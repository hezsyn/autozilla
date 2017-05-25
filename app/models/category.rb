class Category < ApplicationRecord
  has_and_belongs_to_many :category
  has_many :systems

  validates :name, presence: true

end

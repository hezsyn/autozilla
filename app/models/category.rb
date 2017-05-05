class Category < ApplicationRecord
  has_and_belongs_to_many :category

  validates :name, presence: true
end

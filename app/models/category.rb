class Category < ApplicationRecord
  include Azk::Key

  has_many :categories
  has_many :systems

  validates :name, presence: true, uniqueness: { scope: :category_id, message: "Only one is needed"}
end

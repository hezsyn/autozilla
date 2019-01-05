class Category < ApplicationRecord
  has_many :categories
  has_many :systems

  validates :name, presence: true, uniqueness: { scope: :category_id, message: "is already in use."}, format: { with: /\A[a-zA-Z0-9\s\[\]\-\_\.]+\z/, message: 'only letters numbers' }

end
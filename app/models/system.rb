class System < ApplicationRecord
  include Azk::Key

  has_many :images
  has_many :notes

  validates :name, presence: true, uniqueness: { scope: :category_id, message: "is already in use."}, format: { with: /\A[a-zA-Z0-9\s\[\]\-\_\.]+\z/, message: 'only special characters allowed, [] -' }
end

class System < ApplicationRecord
  include Azk::Key

  has_many :images
  has_many :notes

  validates :name, presence: true, uniqueness: { scope: :category_id, message: "Only one is needed"}
end

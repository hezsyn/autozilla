class System < ApplicationRecord
  include Azk::Key

  has_many :images
  has_many :notes

end

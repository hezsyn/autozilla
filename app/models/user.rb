class User < ApplicationRecord
  has_many :images, :logs
end

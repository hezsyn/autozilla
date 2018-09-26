class User < ApplicationRecord
  has_many :searches

  has_secure_password
end

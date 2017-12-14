class User < ApplicationRecord
  has_many :searches


  def self.authenticate(user, password)
    user = find_by_user(user)
    if user && user.password == BCrypt::Engine.hash_secret(password, user.password_digest)
      user
    else
      nil
    end
  end

  def encrypt_password
    if passwor.present?
      self.password_digest = BCrypt::Engine.generate_salt
      self.password = BCrypt::Engine.hash_secret(password, password_digest)
    end
  end

end

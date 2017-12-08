class User < ApplicationRecord
  has_many :searches

  attr_accessible :email, :password, :password_confirmation

  attr_accor :password
  before_save :encrypt_password

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_present_of :user
  validates_uniqueness_of :user

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

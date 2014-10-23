class User < ActiveRecord::Base
  # There's just one small problem, which is that the Active Record uniqueness
  # validation does not guarantee uniqueness at the database level.
  # We need to enforce uniqueness at the database level as wll as at the model level.
  # The method is to create a database index on the email column, and then require
  # that the index be unique.
  has_many :blogs, dependent: :destroy
  attr_accessor :remember_token
  validates :name, presence: true,
            length: {maximum: 50, minimum: 3},
            uniqueness: { case_sensitive: false }
  # Most of the secure password machinery will be implemented using a single Rails method
  # has_secure_password
  # adding the following functionality
  # 1. The ability to save a securely hashed password_digest attribute to the database
  # 2. A pair of virtual attributes(password and password_confirmation), including presence
  #    validations upon object creation and a validation requiring that that match
  # 3. An authenticate method that returns the user when the password is correct, and false
  #    otherwise.

  # The only requirement for has_secure_password to work its magic is for the corresponding model
  # to have an attribute called password_digest.
  has_secure_password
  validates :password, length: { minimum: 6 }

  # Remember a user in the database for use in persistent sessions
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Returns the hash digest of the given string
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end
end

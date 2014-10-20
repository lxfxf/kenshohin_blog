class User < ActiveRecord::Base
  # There's just one small problem, which is that the Active Record uniqueness
  # validation does not guarantee uniqueness at the database level.
  # We need to enforce uniqueness at the database level as wll as at the model level.
  # The method is to create a database index on the email column, and then require
  # that the index be unique.
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
end

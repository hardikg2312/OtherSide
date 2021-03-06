class User < ActiveRecord::Base

  attr_accessor :password
  before_save :encrypt_password

  validates_presence_of   :email
  validates_uniqueness_of :email
  validates_length_of     :email,    :within => 3..100
  validates_format_of     :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_presence_of   :user_name
  validates_uniqueness_of :user_name
  validates_length_of     :user_name,    :within => 3..40
  validates_confirmation_of :password
  validates_presence_of   :password, :on => :create
  validates_length_of     :password, :on => :create,   :within => 5..40
  validates_uniqueness_of :access_token


  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def generate_access_token
    begin
      access_token = SecureRandom.hex
    end while User.exists?(access_token: access_token)
    self.update_attributes(:access_token => access_token)
    access_token
  end

  class << self

    def authenticate(email, password)
      user = find_by_email(email) || find_by_user_name(email)
      return user if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
    end

  end
end

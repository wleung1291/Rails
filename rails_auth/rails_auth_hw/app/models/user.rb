class User < ApplicationRecord
  attr_reader :password

  validates :username, presence: true
  validates :password_digest, presence: {message: 'Password can\'t be blank'}
  validates :session_token, presence: true
  
  validates :password, length: {minimum: 6, allow_nil: true}
  before_validation :ensure_session_token

  # Takes in a username and a password and returns the user that matches
  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end

  # returns a 16-digit pseudorandom string
  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  # This method resets the user's session_token and saves the user after logout
  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end

  # This method sets @password equal to the argument given so that the 
  # appropriate validation can happen
  # This method also encrypts the argument given and saves it as this user's 
  # password_digest
  # Remember to add an attr_reader for password for the validation to occur!
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end


  private
  # Makes sure that the user has a session_token set, setting one if none exists
  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end
end


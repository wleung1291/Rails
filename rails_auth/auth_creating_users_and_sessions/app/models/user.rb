class User < ApplicationRecord
  # the validation will call this to check the attribute. validations do not 
  # need to check only database columns; you can apply a validation to any attribute
  attr_reader :password

  validates :username, presence: true
  validates :password_digest, presence: { message: 'Password can\'t be blank' }
  validates :password, length: { minimum: 6, allow_nil: true }
  # 'allow_nil: true' means the validation will pass if @password is nil (Ex. 
  # u.password). This is desirable, because the @password attribute is only set 
  # if we change the password with #password=

  validates :session_token, presence: true
  # make sure that when we create a User it has a session_token
  after_initialize :ensure_session_token

  def password=(password)
    # used to validate the length of the password since we dont store in the db
    # This saves the password in an instance variable. ActiveRecord will not 
    # try to save the password to the DB, however. Instead, the @password 
    # instance variable will be ignored.
    @password = password

    # ::create factory method takes a password and hashes it.
    self.password_digest = BCrypt::Password.create(password)
  end

  # is_password?() takes a string, hashes the string, and compares it with 
  # the BCrypt::Password. 
  def is_password?(password)
    # Because the digest is already hashed, we use the new constructor rather 
    # than the create factory method; create creates a  Password object by 
    # hashing the input, while new builds a Password object from an existing, 
    # string-ified hash
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end


  # Sessions

  # This will only return a user if the username/password is correct.
  # Used by sessions controller
  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end

  # generate a session token for the User if one isn't already set (that's 
  # the after_initialize callback bit).
  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end
    
  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end

  private 
  # store the session token inside the user
  def ensure_session_token
    # we must be sure to use the ||= operator instead of = or ||, otherwise
    # we will end up with a new session token every time we create
    # a new instance of the User class. This includes finding it in the DB!
    self.session_token ||= self.class.generate_session_token
  end
end
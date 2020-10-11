class User < ApplicationRecord
# Validate the presence of username and session_token
validates :username, presence: true 
validates :session_token, presence: true, uniqueness: true

# Validate the presence of password_digest and set the error message to Password can't be blank
validates :password_digest, presence: { message: 'Password can\'t be blank'}

# Validate the length of password, and set allow_nil to true
validates :password, length: { minimum: 6, allow_nil: true }

# Make sure that ensure_session_token gets called before_validation
before_validation :ensure_session_token

# Remember: you have to add an attr_reader for password for the validation to occur!
attr_reader :password

# This method takes in a username and a password and returns the user that matches
def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return user if user && BCrypt::Password.new(user.password_digest).is_password?(password)
    nil
end

# This is a helper method that uses SecureRandom::urlsafe_base64 and returns a 16-digit pseudorandom string
def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
end

# This method resets the user's session_token and saves the user
def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
end

# This method makes sure that the user has a session_token set, setting one if none exists
def ensure_session_token
    self.session_token ||= User.generate_session_token
end


# This method sets @password equal to the argument given so that the appropriate validation can happen
# This method also encrypts the argument given and saves it as this user's password_digest
def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
end

end
# Example testing code below:

# User.all # shows no users
# empty_gage = User.new
# empty_gage.save # rollback because of failed validations
# password_too_short_gage = User.new(username: 'gage', password: 'test')
# password_too_short_gage.save # rollback because of failed validations
# gage = User.new(username: 'gage', password: 'testing')
# gage.save # inserted into Users
# User.all #<ActiveRecord::Relation [#<User id: 1, username: "gage"...
# User.first.password_digest # shows a string of gibberish that you can't hack


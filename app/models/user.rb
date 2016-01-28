require 'digest/sha2'

class User < ActiveRecord::Base
  attr_reader :password

  validates :username, :password_digest, :session_token, :salt, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  before_validation :ensure_session_token

  def password=(password)
    @password = password
    self.password_digest = Digest::SHA2.hexdigest(salt + password)
  end

  def self.find_by_credentials(username:, password:)
    user = find_by(username: username)
    return nil if user.blank?
    password_digest = Digest::SHA2.hexdigest(user.salt + password)
    user.password_digest == password_digest ? user : nil
  end

  def ensure_session_token
    self.session_token ||= SecureRandom::urlsafe_base64
  end

  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64
    self.save!
  end

  def salt
    self.salt =  super || SecureRandom::urlsafe_base64
  end
end

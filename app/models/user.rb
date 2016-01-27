class User < ActiveRecord::Base
  validates :username, :password_digest, presence: true
  #validates :password, presence: true, length: { minimum: 6 }

  def self.find_by_credentials(username:, password:)
    #TODO

    user = find_by(username: username)
    return nil if user.blank?
    password_digest = Digest::SHA2.hexdigest(password)
    user.password_digest == password_digest ? user : nil
  end
end

class User < ApplicationRecord
  validates :username, presence: true
  validates :password, presence: true, on: :create

  attr_reader :password

  def password=(password)
    @password = password
    self.encrypted_password = Digest::MD5.hexdigest(password)
  end
end

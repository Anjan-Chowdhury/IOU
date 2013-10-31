require 'bcrypt'

class User < ActiveRecord::Base
  attr_accessible :name, :email, :password

  validates :name, :email, :password, presence: :true
  validates :email, uniqueness: true

  has_many :bills

	def password
    @password || self.password_digest
  end

  def password=(password)
  	@password = password
  	self.password_digest = BCrypt::Password.create(password)
  end

  def verify_password(password)
  	BCrypt::Password.new(self.password_digest) == password
  end
end
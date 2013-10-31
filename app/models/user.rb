class User < ActiveRecord::Base
  attr_accessible :name, :email, :password_digest, :session_token

  has_many :bills
end
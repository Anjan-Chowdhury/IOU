require 'bcrypt'

class User < ActiveRecord::Base
  attr_accessible :name, :email, :password

  validates :name, :email, :password, presence: :true, unless: :guest?
  validates :email, :uniqueness => { :case_sensitive => false }, allow_blank: :true
  validates :name, uniqueness: :true, allow_blank: :true

  has_many :bills

  has_many :debts,
    :foreign_key => "debtor_id"
    
  has_many :credits, 
    :class_name => "Debt",
    :foreign_key => "creditor_id"

  has_many :debtors,
    :through => :credits
    
  has_many :creditors, 
    :through => :debts
  
  has_many :invoices,
    :through => :credits,
    :source => :bill,
    :foreign_key => :creditor_id

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

  def to_param
    name
  end

  def self.new_guest
    new { |u| u.guest = true }
  end

  def move_to(user)
  end
end
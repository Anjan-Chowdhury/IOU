class Bill < ActiveRecord::Base
  attr_accessible :description, :name, :amount

  validates :name, :amount, presence: :true

  belongs_to :user
end

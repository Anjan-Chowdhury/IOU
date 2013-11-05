class Debt < ActiveRecord::Base
  attr_accessible :amount, :bill_id, :creditor_id, :creditor_name, :debtor_id, :debtor_name, :is_a_payment, :memo

  belongs_to :bill

	belongs_to :debtor,
    :class_name => "User",
    :foreign_key => :debtor_id
    
  belongs_to :creditor,
    :class_name => "User",
    :foreign_key => :creditor_id
end

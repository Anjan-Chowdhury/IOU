class Bill < ActiveRecord::Base
  attr_accessible :description, :name, :amount, :id, :user

  validates :name, :amount, presence: :true

  belongs_to :user

  has_many :guests

  has_many :debts

  has_many :debtors, 
    :through => :debts, 
    :source => :debtor
    
  has_many :creditors, 
    :through => :debts, 
    :source => :creditor
    
  accepts_nested_attributes_for :debts, 
    :reject_if => :all_blank, 
    :allow_destroy => true

	def self.calculate(bill_id, bill_total, guests_params)	    
	    guests_array = []
	    amount_should_have_paid = bill_total / guests_params.length
	    
	    guests_params.each do |guest|
	      new_guest = Player.new(guest[:name], guest[:amount_paid].to_i, amount_should_have_paid)
	      Guest.create!(:name => guest[:name], :bill_id => bill_id, :amount_paid => guest[:amount_paid].to_i, :amount_should_have_paid => amount_should_have_paid)
	      guests_array.push(new_guest)
	    end
	    
	    guests_who_overpaid = []
	    guests_who_underpaid = []

	    guests_array.each do |guest|
	      guests_who_overpaid.push(guest) if guest.bill_difference > 0
	      guests_who_underpaid.push(guest) if guest.bill_difference < 0
	    end
	    
	    debts_count = 0

	    total_from_debtors = 0

	    guests_who_underpaid.each do |guest|
	      total_from_debtors += guest.amount_owes
	    end

	    guests_who_underpaid.each do |u_guest|
	    
	      guests_who_overpaid.each do |o_guest|
	        owe_to_friend = u_guest.amount_owes * (o_guest.bill_difference/total_from_debtors.to_f)
	        Debt.create!(:bill_id => bill_id, :debtor_id => u_guest.user_id, :creditor_id => o_guest.user_id, :amount => owe_to_friend)
	        debts_count += 1
	      end

		end
	    
		"#{debts_count} debts created for this bill."
	end

  def self.correct_input(bill_total, guests_params)
    guests_payment = 0
    
    guests_params.each do |guest|
      guests_payment += guest[:amount_paid].to_i
    end
    
    guests_payment == bill_total
  end
end

class Player
  attr_accessor :user_id, :amount_paid, :amount_should_have_paid, :id
  
  def initialize(user_id, amount_paid, amount_should_have_paid)
    @user_id = user_id
    @amount_paid = amount_paid
    @amount_should_have_paid = amount_should_have_paid
  end
  
  def bill_difference
    (@amount_paid - @amount_should_have_paid).to_f
  end
  
  def amount_owes
    (@amount_should_have_paid - @amount_paid).to_f
  end
end

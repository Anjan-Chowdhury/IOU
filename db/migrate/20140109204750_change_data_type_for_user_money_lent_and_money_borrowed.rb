class ChangeDataTypeForUserMoneyLentAndMoneyBorrowed < ActiveRecord::Migration
  def self.up
  	change_table :users do |t|
  		t.change :money_lent, :float
  		t.change :money_borrowed, :float
  	end
  end

  def self.down
  	change_table :users do |t|
  		t.change :money_lent, :integer
  		t.change :money_borrowed, :integer
  	end
  end
end


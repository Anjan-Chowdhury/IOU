class ChangeDataTypeForGuestPaidAndShouldHavePaidAmounts < ActiveRecord::Migration
  def self.up
  	change_table :guests do |t|
  		t.change :amount_paid, :float
  		t.change :amount_should_have_paid, :float
  	end
  end

  def self.down
  	change_table :guests do |t|
  		t.change :amount_paid, :integer
  		t.change :amount_should_have_paid, :integer
  	end
  end
end

class ChangeDataTypeForBillAmount < ActiveRecord::Migration
  def self.up
  	change_table :bills do |t|
  		t.change :amount, :float
  	end
  end

  def self.down
  	change_table :bills do |t|
  		t.change :amount, :integer
  	end
  end
end
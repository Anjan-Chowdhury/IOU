class AddAmountAndUserIdToBills < ActiveRecord::Migration
  def change
    add_column :bills, :amount, :integer
    add_column :bills, :user_id, :integer
  end
end

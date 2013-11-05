class AddNamesToDebts < ActiveRecord::Migration
  def change
    add_column :debts, :debtor_name, :string
    add_column :debts, :creditor_name, :string
  end
end

class AddColumnsToUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :session_token
      t.integer :money_lent
      t.integer :money_borrowed

      t.timestamps
    end
  end
end

class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :number
      t.integer :balance
      t.references :user, index: true, foreign_key: true
      t.references :locker, index: true, foreign_key: true
    end
  end
end

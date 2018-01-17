class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :number
      t.boolean :category
      t.integer :amount
      t.references :account, index: true, foreign_key: true
    end
  end
end

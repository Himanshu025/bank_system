class CreateLoans < ActiveRecord::Migration
  def change
    create_table :loans do |t|
      t.string :category
      t.integer :amount
      t.integer :no_of_years
      t.references :account, index: true, foreign_key: true
    end
  end
end

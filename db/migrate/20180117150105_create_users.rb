class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :phone_no
      t.string :email
      t.integer :aadhar_no, limit: 8
    end
  end
end

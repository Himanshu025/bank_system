class CreateLockers < ActiveRecord::Migration
  def change
    create_table :lockers do |t|
    	t.string :section
      t.integer :number
    end
  end
end

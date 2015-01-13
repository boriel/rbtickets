class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :name
      t.string :surname
      t.string :seat
      t.string :phone
      t.text :address
      t.string :email

      t.timestamps
    end
  end
end

class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :name
      t.string :email
      t.string :external_charge_id
      t.integer :ticket_price_id

      t.timestamps
    end
  end
end

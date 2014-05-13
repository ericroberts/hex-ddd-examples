class CreateTicketPrices < ActiveRecord::Migration
  def change
    create_table :ticket_prices do |t|
      t.integer :trip_id, null: false
      t.money   :price, null: false
      t.string  :name, null: false
      t.text    :description

      t.timestamps
    end
  end
end
